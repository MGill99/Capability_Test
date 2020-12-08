
  


    # $interval = Get-Random -Minimum 1 -Maximum 10

    write-host -ForegroundColor Yellow $interval 
        Function startCalls() {
            $clientsAndTokens = ""
            ."C:\Users\Mgill\Desktop\capabilityTest\connectClients.ps1"
            $clientsAndTokens =  Connect-To-AMM
           
                $clientsAndTokens.values | ForEach-Object {
                    
                            $Scriptblock = {
                                Param (
                                    [string]$clientToken
                                 )
                                while($true){
                                    $start = Get-Date
                                    $s = $start.ToString("yyyy-MM-dd HH:mm:ss")
        
                                    write-host "Latest Stats start $s" 
                                  
                                    write-host "out "  $clientToken
                                    $scrips = @(
                                            ,@("/var/capabilityTest/Capability_test/getGroups.ps1" ,  $clientToken) 
                                            ,@("/var/capabilityTest/Capability_test/getGateways.ps1" , $clientToken) 
                                            ,@("/var/capabilityTest/Capability_test/getLatestStats.ps1", $clientToken)
                                            ,@("/var/capabilityTest/Capability_test/getHistoricalStats.ps1", $clientToken)
                                    )
                                    $scrips |  ForEach-Object -Parallel {
                                                write-host "scrip "  $_[0] $_[1]
                                                .$_[0]
                                                runCalls($_[1])
                                    } 
                                    $end = Get-Date 
                                    $e = $end.ToString("yyyy-MM-dd HH:mm:ss")
                                    write-host "Latest Stats end $e" 
            
            
                                    $diff=  ($end - $start).seconds
                                    $diff = 40 - $diff
                                    Write-Output "Wait time after -40 is: $diff"
                                    $last = (Get-Date).AddSeconds($diff)
                                    write-host "last end "  $last.ToString("[yy.MM.dd HH:mm:ss]")
                                    start-sleep -seconds $diff
                                    # while((get-date) -lt $last){
                                    # }
                             }
                            }
                             Start-Job -ScriptBlock $Scriptblock -ArgumentList $_
                             start-sleep -seconds 60

                                    
                            } 
               } 


        startCalls

