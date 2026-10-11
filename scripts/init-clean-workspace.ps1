# CAPTCHA Clean Workspace Initializer
# Run this script in the root of any new repository to establish clean governance.

param (
    [string]$ProjectName = (Split-Path -Leaf (Get-Location))
)

$ErrorActionPreference = "Stop"

Write-Host "Initializing CAPTCHA Clean Workspace for: $ProjectName..." -ForegroundColor Cyan

# 1. Create Local headquarters structure
$localDirs = @(
    "Local\cache",
    "Local\artifacts",
    "Local\evidence",
    "Local\docs",
    "Local\scratch"
)

foreach ($d in $localDirs) {
    if (-not (Test-Path $d)) {
        New-Item -ItemType Directory -Path $d -Force | Out-Null
        Write-Host "Created $d" -ForegroundColor Green
    }
}

# 2. Ensure Local/ is gitignored
$gitignorePath = ".gitignore"
$ignoreEntry = "`n# CAPTCHA Clean Workspace Headquarters`nLocal/`n.worktrees/`n"

if (Test-Path $gitignorePath) {
    $current = Get-Content $gitignorePath -Raw
    if ($current -notmatch "Local/") {
        Add-Content -Path $gitignorePath -Value $ignoreEntry
        Write-Host "Appended Local/ and .worktrees/ to .gitignore" -ForegroundColor Yellow
    }
} else {
    Set-Content -Path $gitignorePath -Value $ignoreEntry
    Write-Host "Created .gitignore with Local/ and .worktrees/" -ForegroundColor Green
}

# 3. Create .worktrees directory
if (-not (Test-Path ".worktrees")) {
    New-Item -ItemType Directory -Path ".worktrees" -Force | Out-Null
    Write-Host "Created .worktrees/ directory" -ForegroundColor Green
}

Write-Host "`n[SUCCESS] CAPTCHA Clean Workspace initialized! Keep your root clean." -ForegroundColor Cyan
