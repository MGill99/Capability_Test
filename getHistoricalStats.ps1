
Function GetGatewayHistoricalStats($clientToken){


    workflow makecalls{
        param(
            [Parameter (Mandatory = $true)]
            [String]$token
        )

        $statKeys =  @("ReportIdleTime")
        # , "CPU-Temperature", "GPS Location-longitude"

        # ForEach -Parallel ($token in $tokens.values)
        # {
        #     Parallel {
                InlineScript {
                    $Header =  @{
                        'Authorization' = "Bearer " + $using:token
                    }

                    $using:statKeys | ForEach-Object{
                        $Parameters = @{
                            targetid = "ND62820053011029"
                            dataid   = $_
                        }
                        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                        (Invoke-WebRequest -Method Get -Uri "https://eng.inmotionnetworks.ca/api/v1/systems/data/raw" -Headers  $Header -Body  $Parameters) 
                        # Start-Job -Name webReq -ScriptBlock {
                        # Wait-Job -Name webReq
                    }
                }
        #     }
        # }
    
    }
    makecalls $clientToken

}


Function runCalls($clientToken){
        GetGatewayHistoricalStats($clientToken)
}