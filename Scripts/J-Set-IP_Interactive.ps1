# J.S Powershell script to change IP Address without GUI
function Write-HostCenter { param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $Message) -ForegroundColor Green }
Write-HostCenter "Hi $env:USERNAME,"
Write-HostCenter "I'm $env:COMPUTERNAME"
Write-HostCenter "&"
Write-HostCenter "This is an interactive script to change your" 
Write-HostCenter "LAPTOP NIC - IPv4 Network Configuration."  #-BackgroundColor DarkCyan -ForegroundColor Green
# For Automated script put constants in virables 
$IP= Read-Host "Please enter desired IP Address:       "  
$MaskBits = Read-Host "Please Enetr Net Mask in Bits(8-30 | Default is 24):  " # Subnet prefix (255.255.255.0)
$Gateway = Read-Host "Please enter Default Gateway for this Network:       "
Write-Host "DNS Set To: 1.1.1.1 & 9.9.9.9" -BackgroundColor DarkGreen -ForegroundColor Cyan
$Dns = "1.1.1.1, 9.9.9.9"
$IPType = "IPv4"
# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter | ? {$_.Name -eq "LAPTOP NIC"}
# Remove any existing IP, gateway from our ipv4 adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}
 # Configure the IP address and default gateway
$adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits `
 -DefaultGateway $Gateway
# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses $DNS