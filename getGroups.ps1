# AMM API parameters
$AMMhost = "https://eng.inmotionnetworks.ca"
Function GetGroups($clientToken) {

    $clientToken.keys | ForEach-Object {
        $Header =  @{
            'Authorization' = "Bearer " + $clientToken.Item($_)
            }
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $groups = ((Invoke-WebRequest -Method Get -Uri "$AMMhost/api/v1/systems/groups"  -Headers $Header).Content)
    
        if ($groups -ne $null){
            return $groups
        }

    }

}

Function runCalls($clientToken){
    while($true){
        GetGroups($clientToken)
    }
}
