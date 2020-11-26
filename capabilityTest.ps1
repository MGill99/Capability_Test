# AMM API parameters
$AMMhost = "https://eng.inmotionnetworks.ca"

# user credentials
$script:AMMuserName = 'mgill'
$script:AMMpassword = 'mobilitymanager'

# Client's encoded credentials Dictionary
$script:clientsDict = @{'client1' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("a81b30bce74c4c7e84c095e7dbaa74a6"+":"+"a36e8fc7bf274680813e7fbcf2aedb23"));
                        'client2' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("dc787751c08a43788c14f7e3201aa7b5"+":"+"dfba8d43534d479486c9cc72e9983e6f"))}                   

$script:clientToken = @{'client1' = "";
                        'client2' = ""}


$script:statKeys = @("ReportIdleTime", "CPU-Temperature", "Location-longitude")
$script:statkeysAsOne = "ReportIdleTime,CPU-Temperature,GPS Location-longitude"
Function Connect-To-AMM(){

    $Parameters = @{
        grant_type = "password"
        username = $script:AMMuserName
        password = $script:AMMpassword
    }

    $script:clientsDict.Keys | ForEach-Object {
        $Header = @{
            Authorization = "Basic " + $script:clientsDict.Item($_)
            'Content-Type' = 'application/x-www-form-urlencoded'
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $credentials = ((Invoke-WebRequest -Method Post -Uri "$AMMhost/api/oauth/token"  -Headers $Header -Body $Parameters).Content | ConvertFrom-Json)

        if ($credentials -ne $null){
            $script:clientToken[$_] = $credentials.access_token
        }
    }

    
}

Connect-To-AMM

$script:clientToken | Format-Table -auto

Function Get-Groups($interval) {

    $script:clientToken.keys | ForEach-Object {
        $Header =  @{
            'Authorization' = "Bearer " + $script:clientToken.Item($_)
            }
            Start-Sleep -s $interval
        $groups = ((Invoke-WebRequest -Method Get -Uri "$AMMhost/api/v1/systems/groups"  -Headers $Header).Content)
    
        if ($groups -ne $null){
            Write-Host -ForegroundColor Yellow "Groups :"
            return $groups
        }

    }

}


Function Get-Gateways($interval) {
    $script:clientToken.keys | ForEach-Object {

        # set Header for GET requestS 
       $Header =  @{
           'Authorization' = "Bearer " + $script:clientToken.Item($_)
       }
       $Parameters = @{
        ids= $ids
    }
       Start-Sleep -s $interval
       $gateways = ((Invoke-WebRequest -Method Get -Uri "$AMMhost/api/v1/systems"  -Headers $Header -Body  $Parameters).Content)
       if ($gateways -ne $null){
           Write-Host -ForegroundColor Yellow "Gateways :"
           return $gateways
       }

      
   }
}

Function Get-Gateway-Latest-Stats($interval){

    $script:clientToken.keys | ForEach-Object {
        $Header =  @{
            'Authorization' = "Bearer " + $script:clientToken.Item($_)
        }
        $Parameters = @{
            ids= $script:statkeysAsOne
        }
        Start-Sleep -s $interval
        $latestStats = ((Invoke-WebRequest -Method Get -Uri "$AMMhost/api/v1/systems/ND62820053011029/data"  -Headers  $Header -Body  $Parameters).Content)
        if ($latestStats -ne $null){
            Write-Host -ForegroundColor Yellow "Latest Stats :"
            return $latestStats
        }
    }
}
Function Get-Gateway-Historical-Stats($interval){

    $script:clientToken.keys | ForEach-Object {
        $Header =  @{
            'Authorization' = "Bearer " + $script:clientToken.Item($_)
        }
        $script:statKeys | ForEach-Object{
            $Parameters = @{
                targetid = "ND62820053011029"
                # from     ="1606297980"
                # to       = "1606301580"
                dataid   = $_
            }
            Start-Sleep -s 1
            $historicalStats = ((Invoke-WebRequest -Method Get -Uri "$AMMhost/api/v1/systems/data/raw"  -Headers $Header -Body  $Parameters).Content)
            if ($historicalStats -ne $null){
                Write-Host -ForegroundColor Yellow "Historical Stats :"
                return $historicalStats
            }
        }
    }
}
$continue = $true 
while($continue){
    
    $interval = Get-Random -Minimum 1 -Maximum 10

    write-host -ForegroundColor Yellow $interval 

    # Get-Groups($interval)
    # Get-Gateway-Latest-Stats($interval)
    # Get-Gateways($interval) 
    Get-Gateway-Historical-Stats($interval)

    if ([console]::KeyAvailable){
        Set-PSReadlineKeyHandler -Chord Ctrl+F8 -ScriptBlock { 
            $continue = $false
        }
        Break
    }
}



# Get-Gateways

# $script:clientToken | Format-Table -auto