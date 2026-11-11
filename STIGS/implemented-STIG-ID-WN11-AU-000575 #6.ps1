<#
.SYNOPSIS
    This PowerShell script ensures that Windows audits MPSSVC Rule-Level Policy Change successes (Policy Change > MPSSVC Rule-Level Policy Change).

.NOTES
    Author          : Ayaan Sheikh
    LinkedIn        : https://www.linkedin.com/in/ayaansheikhofficial/
    GitHub          : https://github.com/ayaan-jpg-cell
    Date Created    : 2026-11-11
    Last Modified   : 2026-11-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000575
    Documentation   : https://stigaview.com/products/win11/v2r11/WN11-AU-000575/

.TESTED ON
    Date(s) Tested  : 2026-11-11
    Tested By       : Ayaan Sheikh
    Systems Tested  : Windows 11 (LOG(N) Pacific lab VM)
    PowerShell Ver. : 5.1

.USAGE
    Run in PowerShell as Administrator, then rescan in Tenable.
    PS C:\> .\implemented-STIG-ID-WN11-AU-000575#6.ps1
#>

# Shows the current audit setting for MPSSVC Rule-Level Policy Change
function Get-AuditSetting {
    $Line = auditpol /get /subcategory:"MPSSVC Rule-Level Policy Change" | Select-String "MPSSVC Rule-Level Policy Change"
    return ($Line.ToString() -replace "MPSSVC Rule-Level Policy Change", "").Trim()
}

# WN11-AU-000575
# Turn on Success auditing for MPSSVC Rule-Level Policy Change (Windows Firewall rule changes)

auditpol /set /subcategory:"MPSSVC Rule-Level Policy Change" /success:enable | Out-Null

# Verify configuration
$Current = Get-AuditSetting
Write-Host "MPSSVC Rule-Level Policy Change auditing is now: $Current"

if ($Current -match "Success") {
    Write-Host "SUCCESS: WN11-AU-000575 configured." -ForegroundColor Green
} else {
    Write-Host "FAILED: Success auditing is not on." -ForegroundColor Red
}
