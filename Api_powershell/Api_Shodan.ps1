$header=@{ "Accept" = "application/json" }
$response=Invoke-WebRequest -Method Get -Uri "" -Headers $header
Write-Output $response