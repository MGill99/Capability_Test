
Function GetGroups($clientToken) {

    $Header =  @{
        'Authorization' = "Bearer " + $clientToken
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    (Invoke-WebRequest -Method Get -Uri "https://eng.inmotionnetworks.ca/api/v1/systems/groups" -Headers  $Header) 
           
}

Function runCalls($clientToken){
        GetGroups($clientToken)
}
