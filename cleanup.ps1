# NEX Genesis Server - Cache Cleanup Script
# PowerShell verzia pre pokrocilejsich uzivatelov

param(
    [switch]$DryRun,
    [switch]$Quiet,
    [string]$Path = "."
)

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  NEX Genesis Server - Cache Cleanup" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Check if Python script exists
$scriptPath = Join-Path $PSScriptRoot "scripts\cleanup_pycache.py"
if (-not (Test-Path $scriptPath)) {
    Write-Host "CHYBA: scripts\cleanup_pycache.py neexistuje!" -ForegroundColor Red
    Write-Host ""
    pause
    exit 1
}

# Activate venv32 if exists
$venvActivate = Join-Path $PSScriptRoot "venv32\Scripts\Activate.ps1"
if (Test-Path $venvActivate) {
    Write-Host "Aktivujem venv32..." -ForegroundColor Yellow
    & $venvActivate
} else {
    Write-Host "Pozor: venv32 nenajdeny, pouzivam system Python" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Cistim cache subory..." -ForegroundColor Yellow
Write-Host ""

# Build arguments
$args = @($scriptPath)
if ($Path -ne ".") {
    $args += $Path
}
if ($DryRun) {
    $args += "--dry-run"
}
if ($Quiet) {
    $args += "--quiet"
}

# Run cleanup script
& python $args

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "  Hotovo!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

# Pause if not running from command line
if ($Host.Name -eq "ConsoleHost") {
    pause
}