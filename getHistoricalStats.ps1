
Function GetGatewayHistoricalStats($clientToken, $AMM_target){

        $statKeys =  @("ReportIdleTime")
        $Header =  @{
            'Authorization' = "Bearer " + $clientToken
        }

        $statKeys | ForEach-Object{
            $Parameters = @{
                targetid = "H060512A0189"
                dataid   = $_
            }
            # [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
            (Invoke-WebRequest -SkipCertificateCheck  -Method Get -Uri "$AMM_target/api/v1/systems/data/raw" -Headers  $Header -Body  $Parameters) 
            
        }
    }


Function runCalls($clientToken, $AMM_target){
        GetGatewayHistoricalStats $clientToken $AMM_target
}