# AMM API parameters
$AMMhost = "https://eng.inmotionnetworks.ca"

# user credentials
$script:AMMuserName = 'mgill'
$script:AMMpassword = 'mobilitymanager'  


# Client's encoded credentials Dictionary
$script:clientsDict = @{'client1' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("a81b30bce74c4c7e84c095e7dbaa74a6"+":"+"a36e8fc7bf274680813e7fbcf2aedb23"));
                        'client2' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("dc787751c08a43788c14f7e3201aa7b5"+":"+"dfba8d43534d479486c9cc72e9983e6f"));
                        'client3' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("9ea45db384b04e2aaaf3149b3e71560a"+":"+"16e730a370f448fba16fa47b1979ad6c"));
                        'client4' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("69c09e5ebc474eca9f255195e85449fa"+":"+"feba00ad21e04462828917cf8cf00c73"));
                        'client5' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("007eb1cd225f4d1eaae6a076c05d2871"+":"+"a0c8251346bb413bbc899e2759ef7571"));
                        'client6' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("d3f6c2f61e7d489fbb00bc395aab8f0a"+":"+"37c8bb889cd54537ad5a9f0cc38b7e32"));
                        'client7' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("04869346b04d4719b820c9b1ba71f9ce"+":"+"e50d8903d7934fe8bfac6457b3248173"));
                        'client8' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("9af0a54634aa4a739ce8101978681b2d"+":"+"5224efdec91743e8b0ce46c07be31844"));
                        'client9' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("f032bd57338944448a5204a5f6c2acc6"+":"+"72e3fce26ccf4c21bc56d17e6a1e71a8"));
                        'client10' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("0812cc5d0751431880528513ec79b760"+":"+"d1a61d78ab8145768b5135b7652bf865"))
                    }

$script:clientUser = @{'client1' = @("CapabilityTest-1", "mobilitymanager");
                        'client2' = @("CapabilityTest-2", "mobilitymanager");
                        'client3' = @("CapabilityTest-3", "mobilitymanager");
                        'client4' = @("CapabilityTest-4", "mobilitymanager");
                        'client5' = @("CapabilityTest-5", "mobilitymanager");
                        'client6' = @("CapabilityTest-6", "mobilitymanager");
                        'client7' = @("CapabilityTest-7", "mobilitymanager");
                        'client8' = @("CapabilityTest-8", "mobilitymanager");
                        'client9' = @("CapabilityTest-9", "mobilitymanager");
                        'client10' = @("CapabilityTest-10", "mobilitymanager")
                    }


Function Connect-To-AMM(){

    $clientToken = @{'client1' = "";
                        'client2' = "";
                        'client3' = "";
                        'client4' = "";
                        'client5' = "";
                        'client6' = "";
                        'client7' = "";
                        'client8' = "";
                        'client9' = "";  
                        'client10' = "";
                    }

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

