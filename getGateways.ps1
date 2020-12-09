Function Get-Gateways($clientToken, $AMM_target) {

        $Header =  @{
            'Authorization' = "Bearer " + $clientToken
        }
        # [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
        (Invoke-WebRequest -SkipCertificateCheck -Method Get -Uri "$AMM_target/api/v1/systems" -Headers  $Header) 
          
    }


Function runCalls($clientToken, $AMM_target){
        
        Get-Gateways $clientToken $AMM_target
        
}