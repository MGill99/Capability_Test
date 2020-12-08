Function GetGatewayLatestStats($clientToken){

        $statkeysAsOne = "ReportIdleTime,CPU-Temperature,GPS Location-longitude"

            
        $Header =  @{
            'Authorization' = "Bearer " + $clientToken
        }
        $Parameters = @{
            ids= $statkeysAsOne
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $url = "https://eng.inmotionnetworks.ca/api/v1/systems/ND62820053011029/data?ids=$statkeysAsOne"
        (Invoke-WebRequest -Method Get -Uri $url -Headers  $Header -Body  $Parameters) 
                        
    
}

Function runCalls($clientToken){
        
        GetGatewayLatestStats($clientToken)
        
}