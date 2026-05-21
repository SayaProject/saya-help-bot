param(
    [string]$EnvFile = ".env",
    [switch]$Build
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $EnvFile)) {
    throw "Missing $EnvFile. Copy .env.example to .env and fill the required values."
}

$required = @("TOKEN", "OWNER_ID", "OWNER_USERNAME", "API_ID", "API_HASH", "DATABASE_URL")
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

if (-not (Test-Path "data")) {
    New-Item -ItemType Directory -Path "data" | Out-Null
}

$image = "saya-help-bot:local"
if ($Build) {
    docker build -f Dockerfile.local -t $image .
}

docker image inspect $image *> $null
if ($LASTEXITCODE -ne 0) {
    docker build -f Dockerfile.local -t $image .
}

docker run --rm -it --env-file $EnvFile -v "${PWD}\data:/app/data" $image
