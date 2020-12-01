# AMM API parameters
$AMMhost = "https://eng.inmotionnetworks.ca"

$script:statKeys =  @("ReportIdleTime", "CPU-Temperature", "GPS Location-longitude")
Function GetGatewayHistoricalStats($clientToken){

    $clientToken.keys | ForEach-Object {
        $Header =  @{
            'Authorization' = "Bearer " + $clientToken.Item($_)
        }
        $script:statKeys | ForEach-Object{
            $Parameters = @{
                targetid = "ND62820053011029"
                dataid   = $_
            }
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $historicalStats = ((Invoke-WebRequest -Method Get -Uri "$AMMhost/api/v1/systems/data/raw"  -Headers $Header -Body  $Parameters).Content)
            if ($historicalStats -ne $null){
                return $historicalStats
            }
        }
    }
}


Function runCalls($clientToken){
    while($true){
        GetGatewayHistoricalStats($clientToken)
    }
}