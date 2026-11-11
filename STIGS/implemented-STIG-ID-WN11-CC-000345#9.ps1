<#
.SYNOPSIS
    This PowerShell script ensures that the WinRM service does not allow Basic authentication.

.NOTES
    Author          : Ayaan Sheikh
    LinkedIn        : https://www.linkedin.com/in/ayaansheikhofficial/
    GitHub          : https://github.com/ayaan-jpg-cell
    Date Created    : 2026-11-11
    Last Modified   : 2026-11-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000345
    Documentation   : https://stigaview.com/products/win11/v2r11/WN11-CC-000345/

.TESTED ON
    Date(s) Tested  : 2026-11-11
    Tested By       : Ayaan Sheikh
    Systems Tested  : Windows 11 (LOG(N) Pacific lab VM)
    PowerShell Ver. : 5.1 (64-bit)

.USAGE
    Run in 64-bit PowerShell as Administrator, then rescan in Tenable.
    PS C:\> .\implemented-STIG-ID-WN11-CC-000345#9.ps1
#>

# WN11-CC-000345
# Disable Basic authentication for the WinRM service
# Registry: HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\AllowBasic = 0

# Stop if running in 32-bit PowerShell (it would write to the wrong registry location)
if (-not [Environment]::Is64BitProcess) {
    Write-Host "FAILED: Run this in 64-bit PowerShell (not x86)." -ForegroundColor Red
    return
}

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"

# Create registry key if it does not exist
if (!(Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Configure AllowBasic as REG_DWORD = 0
New-ItemProperty -Path $RegistryPath `
    -Name "AllowBasic" `
    -Value 0 `
    -PropertyType DWord `
    -Force | Out-Null
