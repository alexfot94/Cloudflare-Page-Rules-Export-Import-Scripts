# Export-PageRules.ps1
# Configuration
$authEmail = "your-email@example.com"
$authKey = "your-global-api-key"
$zoneId = "your-zone-id"
$outputFile = "pagerules_export.json"

$headers = @{
    "X-Auth-Email" = $authEmail
    "X-Auth-Key"   = $authKey
    "Content-Type" = "application/json"
}

# Get Page Rules
$rulesUrl = "https://api.cloudflare.com/client/v4/zones/$zoneId/pagerules"
$rulesResponse = Invoke-RestMethod -Uri $rulesUrl -Headers $headers -Method Get

if ($rulesResponse.success -and $rulesResponse.result.Count -gt 0) {
    $rulesResponse.result | ConvertTo-Json -Depth 10 | Out-File -Encoding UTF8 $outputFile
    Write-Host "Exported $($rulesResponse.result.Count) page rule(s) to '$outputFile'" -ForegroundColor Green
} else {
    Write-Host "No page rules found or export failed." -ForegroundColor Yellow
}
