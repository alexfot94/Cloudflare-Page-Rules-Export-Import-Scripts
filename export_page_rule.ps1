# Export-PageRules.ps1

$apiToken = "your_api_token_here"
$zoneName = "example.com"
$outputFile = "pagerules_export.json"

# Get Zone ID
$zoneResponse = Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones?name=$zoneName" `
  -Headers @{ "Authorization" = "Bearer $apiToken"; "Content-Type" = "application/json" } `
  -Method Get

if (!$zoneResponse.success) {
    Write-Host "Failed to get Zone ID." -ForegroundColor Red
    exit
}

$zoneId = $zoneResponse.result[0].id

# Get Page Rules
$rulesResponse = Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$zoneId/pagerules" `
  -Headers @{ "Authorization" = "Bearer $apiToken"; "Content-Type" = "application/json" } `
  -Method Get

if ($rulesResponse.success) {
    $rulesResponse.result | ConvertTo-Json -Depth 10 | Out-File $outputFile
    Write-Host "Exported $($rulesResponse.result.Count) page rule(s) to $outputFile" -ForegroundColor Green
} else {
    Write-Host "Failed to export page rules." -ForegroundColor Red
}
