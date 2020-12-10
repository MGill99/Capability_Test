# user credentials
$script:AMMuserName = 'admin'
$script:AMMpassword = 'mobilitymanager'  


# Client's encoded credentials Dictionary
$script:clientsDict = @{'client1' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("07b9c7dadb4a404bafbaf94b726d349e"+":"+"e1025059c2d64821b9aef67af20f36af"));
                        'client2' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("9c3ff6f4cf23415587c56c8160243640"+":"+"e01002a203084758add6ab80067ee12b"));
                        'client3' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("7953de1c6de7467089bdd21633e910d6"+":"+"4a432c44f6fb41459abe96eaf18d6e7d"));
                        'client4' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("38736e8fe71a424e9805b30f5a8f21d8"+":"+"5cfea228e20541d382b109dcd0384097"));
                        'client5' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("b034b72cea6b4ba28eac270a7dfb9517"+":"+"4cac29a449c44a1da84677154710361c"));
                        'client6' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("b690a16530b742578b2cfd56a158cbf8"+":"+"d65c49e2654a4d7b8414b1b1f802c04f"));
                        'client7' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("c045ae09bc9c4b8abe5272ee2804fdc5"+":"+"78c06f0476db4d0e898dd78c06c8cc73"));
                        'client8' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("938ba5f0c0fd4180898661775fc5ff72"+":"+"a00ed7a12cfe469e921220556eae136c"));
                        'client9' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("f5f01703b39a4e9ba157f6a72aecb35b"+":"+"f3ec10175d794ae9b4102f09f7191ab6"));
                        'client10' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("1e99252c8e114c39a8eb1559595ab9d8"+":"+"00a6167fc0464344ae7524a167bf8d66"));
                        'client11' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("b537e1e4b2ab48e5aba9c48a5792ddf2"+":"+"590d7c23a4f34d83aab1298b7580caa6"));
                        'client12' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("8ba382d79f2348bcb4120fc413c13e6f"+":"+"110e371ce7a24105bfe924f12c8446d6"));
                        'client13' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("0206166cb9db42d2bae72c6c8595b8f0"+":"+"6358475f5d834ed5911902228c771f78"));
                        'client14' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("fc56a7738c7f4242b870c8afa807e0ee"+":"+"30beb2e67d3c456ca336b6f772eeaa7b"));
                        'client15' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("72712d4d8a36410d9f8983327eb4f72a"+":"+"c96a5b44d0da454fb8eba09c720b0eab"));
                        'client16' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("61b02b6363384543b927a83784e4a586"+":"+"93f7ea3bff8d47b79fe5cf3c5bbf084a"));
                        'client17' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("e994e29b257343c7bed457d134a54383"+":"+"ead146f5090142379f5d0102b6a2a58b"));
                        'client18' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("4f887c16ca554421bc645fb05beda3c6"+":"+"c75c9f0a9d1c4c6f8616b3f9a8025e90"));
                        'client19' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("b380afafcc8644bf8fb81b4f79a7588f"+":"+"c33918ad0ef447eca27324b0922c59b2"));
                        'client20' = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("48688f70c33a44508d8300b169e2fd33"+":"+"b813339bdf4046d48354f601a0d4a73b"))
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
                        'client10' = @("CapabilityTest-10", "mobilitymanager");
                        'client11' = @("CapabilityTest-11", "mobilitymanager");
                        'client12' = @("CapabilityTest-12", "mobilitymanager");
                        'client13' = @("CapabilityTest-13", "mobilitymanager");
                        'client14' = @("CapabilityTest-14", "mobilitymanager");
                        'client15' = @("CapabilityTest-15", "mobilitymanager");
                        'client16' = @("CapabilityTest-16", "mobilitymanager");
                        'client17' = @("CapabilityTest-17", "mobilitymanager");
                        'client18' = @("CapabilityTest-18", "mobilitymanager");
                        'client19' = @("CapabilityTest-19", "mobilitymanager");
                        'client20' = @("CapabilityTest-20", "mobilitymanager")
                    }


Function Connect-To-AMM($AMM_target, $num_of_clients){
    $actual_clientsDict = @($script:clientsDict.keys)[0..$num_of_clients]
    $actual_clientToken =  [System.Collections.Generic.List[string]]::New($num_of_clients)
    write-host  $actual_clientsDict
    
    $actual_clientsDict | ForEach-Object {
        $Header = @{
            Authorization = "Basic " + $script:clientsDict.Item($_)
            'Content-Type' = 'application/x-www-form-urlencoded'
        }

        $Parameters = @{
            grant_type = "password"
            username = $script:clientUser.Item($_)[0]
            password = $script:clientUser.Item($_)[1]
        }

        [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
        $credentials = ((Invoke-WebRequest -SkipCertificateCheck -Method Post -Uri "$AMM_target/api/oauth/token"  -Headers $Header -Body $Parameters).Content | ConvertFrom-Json)
        
        if ($credentials -ne $null){
            $actual_clientToken.add($credentials.access_token)
        }
    }

    return  $actual_clientToken

}

