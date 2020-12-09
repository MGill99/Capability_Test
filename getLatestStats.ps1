Function GetGatewayLatestStats($clientToken, $AMM_target){

        $statkeysAsOne = "ReportIdleTime,CPU-Temperature,GPS Location-longitude"

            
        $Header =  @{
            'Authorization' = "Bearer " + $clientToken
        }
        $Parameters = @{
            ids= $statkeysAsOne
        }
        # [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
        $url = "$AMM_target/api/v1/systems/H060512A0189/data?ids=$statkeysAsOne"
        Invoke-WebRequest -SkipCertificateCheck  -Method Get -Uri $url -Headers  $Header -Body  $Parameters
                        
    
}

Function runCalls($clientToken, $AMM_target){
        
        GetGatewayLatestStats $clientToken $AMM_target
        
}


# H060512A0189   10.1.65.95

# ND62820053011029  eng server