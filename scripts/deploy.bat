@echo off
REM SuperScribe Addon Deployment Batch Script
REM Simple wrapper for the PowerShell deployment script

echo SuperScribe Addon Deployment
echo ============================

REM Check if PowerShell is available
where powershell >nul 2>nul
if errorlevel 1 (
    echo Error: PowerShell not found. Please ensure PowerShell is installed.
    pause
    exit /b 1
)

REM Run the PowerShell deployment script
echo Running PowerShell deployment script...
powershell -ExecutionPolicy Bypass -File "%~dp0deploy.ps1" %*

REM Check if successful
if errorlevel 1 (
    echo.
    echo Deployment failed! Check the error messages above.
    pause
    exit /b 1
)

echo.
echo Deployment completed successfully!
pause