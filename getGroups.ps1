
Function GetGroups($clientToken, $AMM_target) {

    $Header =  @{
        'Authorization' = "Bearer " + $clientToken
    }
    [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    (Invoke-WebRequest -Method Get -SkipCertificateCheck -Uri "$AMM_target/api/v1/systems/groups" -Headers  $Header) 
           
}

Function runCalls($clientToken, $AMM_target){
        GetGroups $clientToken $AMM_target
}
