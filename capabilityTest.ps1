

    # $interval = Get-Random -Minimum 1 -Maximum 10

    write-host -ForegroundColor Yellow $interval 
    workflow Test-Workflow{
        $clientsAndTokens = ""
            workflow Make-API-calls{
                $clientsAndTokens = InlineScript{ 
                
                    ."C:\Users\Mgill\Desktop\capabilityTest\connectClients.ps1"
                    Connect-To-AMM
                }
                $getGroups = InlineScript {
                    ."C:\Users\Mgill\Desktop\capabilityTest\getGroups.ps1" 
                    write-host $Using:clientsAndTokens
                    runCalls($Using:clientsAndTokens)
                
                }
                $getLatestStats = InlineScript {
                    ."C:\Users\Mgill\Desktop\capabilityTest\getLatestStats.ps1" 
                    write-host $Using:clientsAndTokens
                    runCalls($Using:clientsAndTokens)
                
                }
                $getGateways = InlineScript {
                    ."C:\Users\Mgill\Desktop\capabilityTest\getGateways.ps1" 
                    write-host $Using:clientsAndTokens
                    runCalls($Using:clientsAndTokens)
                
                }
                $scrips = @($getGroups , $getLatestStats,  $getGateways)

                ForEach -Parallel ($scrip in $scrips)
                {
                    Parallel {
                        
                    }
                }
                
                #    parallel{
                #         InlineScript {
                #             ."C:\Users\Mgill\Desktop\capabilityTest\getGroups.ps1" 
                #             write-host $Using:clientsAndTokens
                #             runCalls($Using:clientsAndTokens)
                        
                #         }  
                #         InlineScript {
                #             ."C:\Users\Mgill\Desktop\capabilityTest\getLatestStats.ps1" 
                #             write-host $Using:clientsAndTokens
                #             runCalls($Using:clientsAndTokens)
                        
                #         }
                #         InlineScript {
                #             ."C:\Users\Mgill\Desktop\capabilityTest\getGateways.ps1" 
                #             write-host $Using:clientsAndTokens
                #             runCalls($Using:clientsAndTokens)
                        
                #         }
                #         InlineScript {
                #             ."C:\Users\Mgill\Desktop\capabilityTest\getHistoricalStats.ps1" 
                #             write-host $Using:clientsAndTokens
                #             runCalls($Using:clientsAndTokens)
                        
                #         }
                        
                #    } 
              }
              Make-API-calls 
                
        }
    Test-Workflow

