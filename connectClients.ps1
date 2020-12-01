# AMM API parameters
$AMMhost = "https://eng.inmotionnetworks.ca"

# user credentials
$script:AMMuserName = 'mgill'
$script:AMMpassword = 'mobilitymanager'  


# Client's encoded credentials Dictionary
$script:clientsDict = @{'client1' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("a81b30bce74c4c7e84c095e7dbaa74a6"+":"+"a36e8fc7bf274680813e7fbcf2aedb23"));
                        'client2' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("dc787751c08a43788c14f7e3201aa7b5"+":"+"dfba8d43534d479486c9cc72e9983e6f"));
                        'client3' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("9ea45db384b04e2aaaf3149b3e71560a"+":"+"16e730a370f448fba16fa47b1979ad6c"));
                        'client4' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("69c09e5ebc474eca9f255195e85449fa"+":"+"feba00ad21e04462828917cf8cf00c73"))}

$script:clientUser = @{'client1' = @("CapabilityTest-1", "mobilitymanager");
                        'client2' = @("CapabilityTest-2", "mobilitymanager");
                        'client3' = @("CapabilityTest-3", "mobilitymanager");
                        'client4' = @("CapabilityTest-4", "mobilitymanager")}


Function Connect-To-AMM(){

    $clientToken = @{'client1' = "";
                        'client2' = "";
                        'client3' = "";
                        'client4' = ""}

    $script:clientsDict.Keys | ForEach-Object {
        $Header = @{
            Authorization = "Basic " + $script:clientsDict.Item($_)
            'Content-Type' = 'application/x-www-form-urlencoded'
        }

        $Parameters = @{
            grant_type = "password"
            username = $script:clientUser.Item($_)[0]
            password = $script:clientUser.Item($_)[1]
        }

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $credentials = ((Invoke-WebRequest -Method Post -Uri "$AMMhost/api/oauth/token"  -Headers $Header -Body $Parameters).Content | ConvertFrom-Json)

        if ($credentials -ne $null){
            $clientToken[$_] = $credentials.access_token
        }
    }

    return $clientToken

}

