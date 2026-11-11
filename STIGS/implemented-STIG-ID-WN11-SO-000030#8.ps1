<#
.SYNOPSIS
    This PowerShell script ensures that "Audit: Force audit policy subcategory settings to override audit policy category settings" is enabled.

.NOTES
    Author          : Ayaan Sheikh
    LinkedIn        : https://www.linkedin.com/in/ayaansheikhofficial/
    GitHub          : https://github.com/ayaan-jpg-cell
    Date Created    : 2026-11-11
    Last Modified   : 2026-11-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000030
    Documentation   : https://stigaview.com/products/win11/v2r11/WN11-SO-000030/

.TESTED ON
    Date(s) Tested  : 2026-11-11
    Tested By       : Ayaan Sheikh
    Systems Tested  : Windows 11 (LOG(N) Pacific lab VM)
    PowerShell Ver. : 5.1

.USAGE
    Run in PowerShell as Administrator, then rescan in Tenable.
    PS C:\> .\implemented-STIG-ID-WN11-SO-000030#8.ps1
#>

# WN11-SO-000030
# Force audit policy subcategory settings to override category settings
# Registry: HKLM\SYSTEM\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy = 1

$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"

# Configure SCENoApplyLegacyAuditPolicy as REG_DWORD = 1
New-ItemProperty -Path $RegistryPath `
    -Name "SCENoApplyLegacyAuditPolicy" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

# Verify configuration
$Result = Get-ItemProperty -Path $RegistryPath -Name "SCENoApplyLegacyAuditPolicy"
Write-Host "SCENoApplyLegacyAuditPolicy is now: $($Result.SCENoApplyLegacyAuditPolicy)"

if ($Result.SCENoApplyLegacyAuditPolicy -eq 1) {
    Write-Host "SUCCESS: WN11-SO-000030 configured." -ForegroundColor Green
} else {
    Write-Host "FAILED: Setting is not enabled." -ForegroundColor Red
}
