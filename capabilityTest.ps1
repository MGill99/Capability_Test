
  


    # $interval = Get-Random -Minimum 1 -Maximum 10

    write-host -ForegroundColor Yellow $interval 
    workflow Test-Workflow{
        $clientsAndTokens = ""
            workflow Make-API-calls{
                $clientsAndTokens = InlineScript{ 
                
                    ."C:\Users\Mgill\Desktop\capabilityTest\connectClients.ps1"
                    Connect-To-AMM
                }
                $scrips= @( 
                "\getGroups.ps1",
                 "\getGateways.ps1",
                 "\getLatestStats.ps1",
                "\getHistoricalStats.ps1"
                )

               ForEach -Parallel ($clientToken in $clientsAndTokens.values){
                    parallel {
                        # $interval = Get-Random -Minimum 1 -Maximum 10
                        Start-Sleep -s 40
                        while($true){
                                    $start = Get-Date
                                    $s = $start.ToString("yyyy-MM-dd HH:mm:ss")
                                    InlineScript {
                                        write-host ($using:clientToken)
                                        write-host "Latest Stats start $using:s" }
                                
                                    ForEach -Parallel ($scrip in $scrips)
                                    {
                                        parallel {
                                            InlineScript{ 
                                                .$using:scrip
                                                runCalls($Using:clientToken)
                
                                            
                                            } 
                                        }
                                    } 
                                    InlineScript{
                                        $end = Get-Date 
                                        $e = $end.ToString("yyyy-MM-dd HH:mm:ss")
                                        write-host "Latest Stats end $e" 
                
                
                                        $diff=  ($end - $using:start).seconds
                                        $diff = 40 - $diff
                                            Write-Output "Wait time after -40 is: $diff"
                                        $last = (Get-Date).AddSeconds($diff)
                                        write-host "last end "  $last.ToString("[yy.MM.dd HH:mm:ss]")
                                        while((get-date) -lt $last){
                                        }
                                           
                                    }
                                    
                                    
                                    
                            }
                    }
               }
           
                
              }
              Make-API-calls 
                
        }

       


    Test-Workflow


    ead-Host -Prompt "Press Enter to exit"