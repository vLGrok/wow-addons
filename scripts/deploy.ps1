# SuperScribe Addon Deployment Script
# Deploys the SuperScribe addon to World of Warcraft Classic AddOns directory

param(
    [string]$WowPath = "D:\Blizzard\World of Warcraft\_classic_\Interface\AddOns",
    [switch]$Force,
    [switch]$Verbose
)

# Configuration
$AddonName = "SuperScribe"
$SourcePath = Join-Path $PSScriptRoot "..\AddOns\$AddonName"
$TargetPath = Join-Path $WowPath $AddonName

Write-Host "SuperScribe Addon Deployment Script" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green

# Validate source path exists
if (-not (Test-Path $SourcePath)) {
    Write-Error "Source addon path not found: $SourcePath"
    Write-Host "Please ensure you're running this script from the repository root/scripts directory."
    exit 1
}

# Validate WoW AddOns directory exists
if (-not (Test-Path $WowPath)) {
    Write-Error "WoW AddOns directory not found: $WowPath"
    Write-Host "Please check your WoW installation path or specify the correct path with -WowPath parameter."
    Write-Host "Example: .\deploy.ps1 -WowPath 'C:\Program Files (x86)\World of Warcraft\_classic_\Interface\AddOns'"
    exit 1
}

Write-Host "Source: $SourcePath" -ForegroundColor Cyan
Write-Host "Target: $TargetPath" -ForegroundColor Cyan

# Check if target already exists
if (Test-Path $TargetPath) {
    if (-not $Force) {
        $response = Read-Host "Target addon directory already exists. Overwrite? (y/N)"
        if ($response -notmatch '^[Yy]$') {
            Write-Host "Deployment cancelled." -ForegroundColor Yellow
            exit 0
        }
    }
    
    Write-Host "Removing existing addon directory..." -ForegroundColor Yellow
    Remove-Item $TargetPath -Recurse -Force
}

# Copy addon to WoW directory
try {
    Write-Host "Deploying $AddonName..." -ForegroundColor Green
    Copy-Item $SourcePath $TargetPath -Recurse -Force
    
    if ($Verbose) {
        Write-Host "Files deployed:" -ForegroundColor Cyan
        Get-ChildItem $TargetPath -Recurse | ForEach-Object {
            $relativePath = $_.FullName.Substring($TargetPath.Length)
            Write-Host "  $AddonName$relativePath" -ForegroundColor Gray
        }
    }
    
    Write-Host ""
    Write-Host "✅ Deployment successful!" -ForegroundColor Green
    Write-Host "The $AddonName addon has been deployed to:" -ForegroundColor White
    Write-Host "   $TargetPath" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Launch World of Warcraft Classic" -ForegroundColor White
    Write-Host "2. Type '/reload' in-game to reload your UI" -ForegroundColor White
    Write-Host "3. Type '/ss' to open SuperScribe or look for the minimap button" -ForegroundColor White
    
} catch {
    Write-Error "Failed to deploy addon: $_"
    exit 1
}

# Optional: Check for required libraries
Write-Host ""
Write-Host "📋 Dependency Check:" -ForegroundColor Yellow
Write-Host "This addon requires Ace3 libraries. The current version includes stub libraries." -ForegroundColor White
Write-Host "For full functionality, download Ace3 from:" -ForegroundColor White
Write-Host "   https://www.curseforge.com/wow/addons/ace3" -ForegroundColor Cyan
Write-Host "   https://www.curseforge.com/wow/addons/libdbicon-1-0" -ForegroundColor Cyan