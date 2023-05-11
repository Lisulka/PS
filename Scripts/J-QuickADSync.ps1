# J.S Script 4 Quick ADSync - Remotely
function Write-HostCenter { param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $Message) -ForegroundColor Green }
Write-HostCenter "^_^"
Write-HostCenter "Hello there"
#Write-HostCenter "This is J.S Script 4 Quick ADSync"
Write-HostCenter "You're about to initiate Azure Active Directory Sync Cycle"
Write-HostCenter "Please follow the instructions below:"

# For Invoke-Command to work, you must have PowerShell Remoting enabled and available on the remote computer. 
# By default, all Windows Server 2012 R2 or later machines do have it enabled along with the appropriate firewall exceptions.
Invoke-Command -ComputerName 'ADSyncSRV' -ScriptBlock {
Set-Location C:\
    .\J-ADSync.ps1
} 
