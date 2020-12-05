Function GetGatewayLatestStats($clientToken){

    workflow make-calls{
        param(
            [Parameter (Mandatory = $true)]
            [String]$token
        )

        $statkeysAsOne = "ReportIdleTime,CPU-Temperature,GPS Location-longitude"

            # ForEach -Parallel ($token in $tokens.values)
            # {
                
            #     Parallel {
                    InlineScript {
                        $Header =  @{
                            'Authorization' = "Bearer " + $using:token
                        }
                        $Parameters = @{
                            ids= $using:statkeysAsOne
                        }
                        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                        $url = "https://eng.inmotionnetworks.ca/api/v1/systems/ND62820053011029/data?ids=$using:statkeysAsOne"
                        (Invoke-WebRequest -Method Get -Uri $url -Headers  $Header -Body  $Parameters) 
                        # Start-Job -Name webReq -ScriptBlock {
                        # Wait-Job -Name webReq
                        
                    } 
                # }
            # }
        

    }

    make-calls $clientToken
}

Function runCalls($clientToken){
        
        GetGatewayLatestStats($clientToken)
        
}