
Function GetGroups($clientToken) {

    workflow makecalls{
        param(
            [Parameter (Mandatory = $true)]
            [String]$token
        )
        

        # ForEach -Parallel ($token in $tokens.values)
        # {
        #     Parallel {
                InlineScript {
                    $Header =  @{
                        'Authorization' = "Bearer " + $using:token
                    }
                    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
                    (Invoke-WebRequest -Method Get -Uri "https://eng.inmotionnetworks.ca/api/v1/systems/groups" -Headers  $Header -Body  $Parameters) 
                    # Start-Job -Name webReq -ScriptBlock 
                    # Wait-Job -Name webReq
                }
        #     }
        # }
           
    }

    
    makecalls $clientToken
}


Function runCalls($clientToken){
        GetGroups($clientToken)
}
