<#
.SYNOPSIS
    This PowerShell script ensures that accounts lock after 3 or fewer bad logon attempts.

.NOTES
    Author          : Ayaan Sheikh
    LinkedIn        : https://www.linkedin.com/in/ayaansheikhofficial/
    GitHub          : https://github.com/ayaan-jpg-cell
    Date Created    : 2026-11-11
    Last Modified   : 2026-11-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010
    Documentation   : https://stigaview.com/products/win11/v2r11/WN11-AC-000010/

.TESTED ON
    Date(s) Tested  : 2026-11-11
    Tested By       : Ayaan Sheikh
    Systems Tested  : Windows 11 (LOG(N) Pacific lab VM)
    PowerShell Ver. : 5.1

.USAGE
    Run in PowerShell as Administrator, then rescan in Tenable.
    PS C:\> .\implemented-STIG-ID-WN11-AC-000010#10.ps1
#>

# WN11-AC-000010
# Lock accounts after 3 bad logon attempts (Account Lockout Policy, not registry)

net accounts /lockoutthreshold:3 | Out-Null

# Verify configuration
$Line = (net accounts) | Select-String "Lockout threshold"
$Threshold = ($Line.ToString() -split ":")[-1].Trim()

Write-Host "Lockout threshold is now: $Threshold"

if ($Threshold -match '^\d+$' -and [int]$Threshold -ge 1 -and [int]$Threshold -le 3) {
    Write-Host "SUCCESS: WN11-AC-000010 lockout threshold configured." -ForegroundColor Green
} else {
    Write-Host "FAILED: Lockout threshold is not 1 to 3." -ForegroundColor Red
}
