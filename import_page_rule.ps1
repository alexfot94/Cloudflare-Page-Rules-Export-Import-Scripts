# Import-PageRules.ps1
# Configuration
$authEmail = "your-email@example.com"
$authKey = "your-global-api-key"
$zoneId = "your-zone-id"
$inputFile = "pagerules_export.json"

$headers = @{
    "X-Auth-Email" = $authEmail
    "X-Auth-Key"   = $authKey
    "Content-Type" = "application/json"
}

# Check if file exists
if (-Not (Test-Path $inputFile)) {
    Write-Host "Input file '$inputFile' not found." -ForegroundColor Red
    exit 1
}

$pageRules = Get-Content $inputFile | ConvertFrom-Json

if (-not $pageRules -or $pageRules.Count -eq 0) {
    Write-Host "No rules to import from '$inputFile'" -ForegroundColor Yellow
    exit 1
}

foreach ($rule in $pageRules) {
    # Optional: remove ID to avoid update conflict
    $rule.PSObject.Properties.Remove("id")

    $ruleBody = $rule | ConvertTo-Json -Depth 10
    $importUrl = "https://api.cloudflare.com/client/v4/zones/$zoneId/pagerules"
    $response = Invoke-RestMethod -Uri $importUrl -Headers $headers -Method Post -Body $ruleBody

    if ($response.success) {
        Write-Host "Imported rule for URL pattern: $($rule.targets[0].constraint.value)" -ForegroundColor Green
    } else {
        Write-Host "Failed to import rule: $($rule.targets[0].constraint.value)" -ForegroundColor Red
    }
}
