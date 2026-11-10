
<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Ayaan Sheikh
    LinkedIn        : https://www.linkedin.com/in/ayaansheikhofficial/
    GitHub          : https://github.com/ayaan-jpg-cell
    Date Created    : 2026-09-11
    Last Modified   : 2026-09-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AU-000500/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE# WN11-AU-000500
# Configure Application Event Log Maximum Size to 32768 KB (32 MB)

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

# Create registry key if it does not exist
if (!(Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Configure MaxSize as REG_DWORD
New-ItemProperty -Path $RegistryPath `
    -Name "MaxSize" `
    -Value 32768 `
    -PropertyType DWord `
    -Force | Out-Null

# Verify configuration
$Result = Get-ItemProperty -Path $RegistryPath -Name "MaxSize"

Write-Host "Application Event Log MaxSize: $($Result.MaxSize) KB"

if ($Result.MaxSize -eq 32768) {
    Write-Host "SUCCESS: WN11-AU-000500 registry setting configured." -ForegroundColor Green
} else {
    Write-Host "FAILED: Registry value is incorrect." -ForegroundColor Red
}
