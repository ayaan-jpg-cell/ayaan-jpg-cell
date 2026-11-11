<#
.SYNOPSIS
    This PowerShell script ensures that the built-in Guest account is renamed to something other than "Guest".

.NOTES
    Author          : Ayaan Sheikh
    LinkedIn        : https://www.linkedin.com/in/ayaansheikhofficial/
    GitHub          : https://github.com/ayaan-jpg-cell
    Date Created    : 2026-11-11
    Last Modified   : 2026-11-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000025
    Documentation   : https://stigaview.com/products/win11/v2r11/WN11-SO-000025/

.TESTED ON
    Date(s) Tested  : 2026-11-11
    Tested By       : Ayaan Sheikh
    Systems Tested  : Windows 11 (LOG(N) Pacific lab VM)
    PowerShell Ver. : 5.1

.USAGE
    Run in PowerShell as Administrator, then rescan in Tenable.
    PS C:\> .\implemented-STIG-ID-WN11-SO-000025#7.ps1
#>

# WN11-SO-000025
# Rename the built-in Guest account (SID always ends in -501)

$NewName = "xGuestAcct"
$Filter  = "LocalAccount=True AND SID LIKE '%-501'"

# Find the built-in Guest account
$Guest = Get-CimInstance -ClassName Win32_UserAccount -Filter $Filter

if (-not $Guest) {
    Write-Host "FAILED: Could not find the built-in Guest account." -ForegroundColor Red
    return
}

# Rename it if it is still called Guest
if ($Guest.Name -eq "Guest") {
    Invoke-CimMethod -InputObject $Guest -MethodName Rename -Arguments @{ Name = $NewName } | Out-Null
}

# Verify configuration
$Guest = Get-CimInstance -ClassName Win32_UserAccount -Filter $Filter
Write-Host "Built-in Guest account is now named: $($Guest.Name)"

if ($Guest -and $Guest.Name -ne "Guest") {
    Write-Host "SUCCESS: WN11-SO-000025 Guest account renamed." -ForegroundColor Green
} else {
    Write-Host "FAILED: Guest account is still named Guest." -ForegroundColor Red
}
