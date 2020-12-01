
# AMM API parameters
$AMMhost = "https://eng.inmotionnetworks.ca"

Function Get-Gateways($clientToken) {
    $clientToken.keys | ForEach-Object {

        # set Header for GET requestS 
       $Header =  @{
           'Authorization' = "Bearer " + $clientToken.Item($_)
       }
       $Parameters = @{
        ids= $ids
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
       $gateways = ((Invoke-WebRequest -Method Get -Uri "$AMMhost/api/v1/systems"  -Headers $Header -Body  $Parameters).Content)
       if ($gateways -ne $null){
           return $gateways
       }

      
   }
}

Function runCalls($clientToken){
    while($true){
        Get-Gateways($clientToken)
    }
}