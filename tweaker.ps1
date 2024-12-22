# Script: Windows Tweaker
# Description: Applies common system tweaks for performance and usability.
# Author: [Your Name]

# Check for admin privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit
}

Write-Host "Applying Windows tweaks..." -ForegroundColor Green

# Disable telemetry services
Write-Host "Disabling telemetry services..."
Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
Set-Service -Name "dmwappushservice" -StartupType Disabled -ErrorAction SilentlyContinue

# Enable Dark Mode
Write-Host "Enabling dark mode for Windows Explorer..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0

# Disable Cortana
Write-Host "Disabling Cortana..."
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Force

# Speed up menu animations
Write-Host "Speeding up menu animations..."
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value 20

# Disable Xbox Game Bar
Write-Host "Disabling Xbox Game Bar..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0

# Turn off Windows Tips
Write-Host "Turning off Windows tips..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Value 0

# Remove bloatware apps
Write-Host "Removing bloatware apps..."
Get-AppxPackage -AllUsers | Where-Object { $_.Name -match "BingWeather|GetHelp|WindowsMaps|XboxApp|YourPhone" } | Remove-AppxPackage -ErrorAction SilentlyContinue

Write-Host "Tweaks applied successfully! Please restart your computer for some changes to take effect." -ForegroundColor Green
