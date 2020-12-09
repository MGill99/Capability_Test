
        Function startCalls() {
        $clientsAndTokens = ""
        ."/var/capabilityTest/Capability_Test/connectClients.ps1"
        $clientsAndTokens =  Connect-To-AMM $script:AMM_Target $script:Num_of_clients
        $clientsAndTokens | ForEach-Object {

            $Scriptblock = {
                Param (
                    [string]$clientToken,
                    [string]$target
                    )
                while($true){
                    $start = Get-Date
                    $s = $start.ToString("yyyy-MM-dd HH:mm:ss")

                    write-host "Latest Stats start $s" 
                    
                    $scrips = @(
                            ,@("/var/capabilityTest/Capability_Test/getGroups.ps1" ,  $clientToken, $target) 
                            ,@("/var/capabilityTest/Capability_Test/getGateways.ps1" , $clientToken, $target) 
                            ,@("/var/capabilityTest/Capability_Test/getLatestStats.ps1", $clientToken, $target)
                            ,@("/var/capabilityTest/Capability_Test/getHistoricalStats.ps1", $clientToken, $target)
                    )
                    $scrips |  ForEach-Object -Parallel {
                                write-host "scrip "  $_[0] $_[1] $_[2]
                                .$_[0]
                                runCalls $_[1] $_[2]
                    } 
                    $end = Get-Date 
                    $e = $end.ToString("yyyy-MM-dd HH:mm:ss")
                    write-host "Latest Stats end $e" 


                    $diff=  ($end - $start).seconds
                    $diff = 40 - $diff
                    Write-Output "Wait time after -40 is: $diff"
                    start-sleep -seconds $diff
                }
            }
                start-job -ScriptBlock $Scriptblock -ArgumentList $_, $script:AMM_Target
                start-sleep -seconds 60

                    
            } 
        } 


        $script:AMM_Target=$args[0]
        $script:Num_of_clients=$args[1]

        startCalls

