param(
    [string]$EnvFile = ".env",
    [switch]$Build
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $EnvFile)) {
    throw "Missing $EnvFile. Copy .env.example to .env and fill the required values."
}

$required = @("TOKEN", "OWNER_ID", "OWNER_USERNAME", "API_ID", "API_HASH")
$values = @{}

Get-Content $EnvFile | ForEach-Object {
    $line = $_.Trim()
    if (-not $line -or $line.StartsWith("#")) {
        return
    }

    $parts = $line.Split("=", 2)
    if ($parts.Count -eq 2) {
        $values[$parts[0].Trim()] = $parts[1].Trim()
    }
}

$missing = $required | Where-Object { -not $values.ContainsKey($_) -or [string]::IsNullOrWhiteSpace($values[$_]) }
if ($missing) {
    throw "Missing required env values: $($missing -join ', ')"
}

$composeFile = "docker-compose.local.yml"
if (-not (Test-Path $composeFile)) {
    throw "Missing $composeFile."
}

docker compose version *> $null
if ($LASTEXITCODE -ne 0) {
    throw "Docker Compose is required. Install Docker Desktop, then run this script again."
}

$composeArgs = @("-f", $composeFile, "up", "-d")
if ($Build) {
    $composeArgs += "--build"
}

docker compose @composeArgs
docker compose -f $composeFile ps
Write-Host ""
Write-Host "Bot is starting. Press Ctrl+C to stop watching logs; the containers will keep running."
docker compose -f $composeFile logs -f bot
