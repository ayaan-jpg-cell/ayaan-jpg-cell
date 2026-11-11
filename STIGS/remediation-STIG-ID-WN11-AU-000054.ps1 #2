<#
.SYNOPSIS
    This PowerShell script ensures that Windows audits Account Lockout failures (Logon/Logoff > Account Lockout).

.NOTES
    Author          : Ayaan Sheikh
    LinkedIn        : https://www.linkedin.com/in/ayaansheikhofficial/
    GitHub          : https://github.com/ayaan-jpg-cell
    Date Created    : 2026-11-10
    Last Modified   : 2026-11-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000054
    Documentation   : https://stigaview.com/products/win11/v2r11/WN11-AU-000054/

.TESTED ON
    Date(s) Tested  : 2026-11-10
    Tested By       : Ayaan Sheikh
    Systems Tested  : Windows 11 (LOG(N) Pacific lab VM)
    PowerShell Ver. : 5.1

.USAGE
    Run in PowerShell as Administrator, then rescan in Tenable.
    PS C:\> .\remediation-STIG-ID-WN11-AU-000054.ps1
#>

# Shows the current audit setting for Account Lockout
function Get-AuditSetting {
    $Line = auditpol /get /subcategory:"Account Lockout" | Select-String "Account Lockout"
    return ($Line.ToString() -replace "Account Lockout", "").Trim()
}

# WN11-AU-000054
# Turn on Failure auditing for Account Lockout

auditpol /set /subcategory:"Account Lockout" /failure:enable | Out-Null

# Verify configuration
$Current = Get-AuditSetting
Write-Host "Account Lockout auditing is now: $Current"

if ($Current -match "Failure") {
    Write-Host "SUCCESS: WN11-AU-000054 configured." -ForegroundColor Green
} else {
    Write-Host "FAILED: Failure auditing is not on." -ForegroundColor Red
}
