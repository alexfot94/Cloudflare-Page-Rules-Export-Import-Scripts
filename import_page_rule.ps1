# Import-PageRules.ps1

$apiToken = "your_api_token_here"
$zoneName = "example.com"
$inputFile = "pagerules_export.json"

# Get Zone ID
$zoneResponse = Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones?name=$zoneName" `
  -Headers @{ "Authorization" = "Bearer $apiToken"; "Content-Type" = "application/json" } `
  -Method Get

if (!$zoneResponse.success) {
    Write-Host "Failed to get Zone ID." -ForegroundColor Red
    exit
}

$zoneId = $zoneResponse.result[0].id

# Load exported rules
$pageRules = Get-Content $inputFile | ConvertFrom-Json

$i = 1
foreach ($rule in $pageRules) {
    $payload = @{
        targets = $rule.targets
        actions = $rule.actions
        priority = $rule.priority
        status = $rule.status
    }

    $jsonPayload = $payload | ConvertTo-Json -Depth 10

    $importResponse = Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$zoneId/pagerules" `
      -Headers @{ "Authorization" = "Bearer $apiToken"; "Content-Type" = "application/json" } `
      -Method Post `
      -Body $jsonPayload

    if ($importResponse.success) {
        Write-Host "[$i] Imported rule successfully." -ForegroundColor Green
    } else {
        Write-Host "[$i] Failed to import rule: $($importResponse.errors | ConvertTo-Json)" -ForegroundColor Red
    }

    Start-Sleep -Seconds 1
    $i++
}
