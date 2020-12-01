

# AMM API parameters
$AMMhost = "https://eng.inmotionnetworks.ca"

$script:statkeysAsOne = "ReportIdleTime,CPU-Temperature,GPS Location-longitude"

Function GetGatewayLatestStats($clientToken){

    $clientToken.keys | ForEach-Object {
        $Header =  @{
            'Authorization' = "Bearer " + $clientToken.Item($_)
        }
        $Parameters = @{
            ids= $script:statkeysAsOne
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $latestStats = ((Invoke-WebRequest -Method Get -Uri "$AMMhost/api/v1/systems/ND62820053011029/data"  -Headers  $Header -Body  $Parameters).Content)
        if ($latestStats -ne $null){
            return $latestStats
        }
    }
}

Function runCalls($clientToken){
    while($true){
        GetGatewayLatestStats($clientToken)
    }
}