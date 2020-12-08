
Function GetGatewayHistoricalStats($clientToken){

        $statKeys =  @("ReportIdleTime")
        $Header =  @{
            'Authorization' = "Bearer " + $clientToken
        }

        $statKeys | ForEach-Object{
            $Parameters = @{
                targetid = "ND62820053011029"
                dataid   = $_
            }
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            (Invoke-WebRequest -Method Get -Uri "https://eng.inmotionnetworks.ca/api/v1/systems/data/raw" -Headers  $Header -Body  $Parameters) 
            
        }
    }


Function runCalls($clientToken){
        GetGatewayHistoricalStats($clientToken)
}