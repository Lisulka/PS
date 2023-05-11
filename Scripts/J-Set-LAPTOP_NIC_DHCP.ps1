# J.S Powershell script to change NIC conf to get IP via  DHCP without GUI
$IPType = "IPv4"
$adapter = Get-NetAdapter | ? {$_.Name -eq "LAPTOP NIC"} # Change the NIC Name
$interface = $adapter | Get-NetIPInterface -AddressFamily $IPType
If ($interface.Dhcp -eq "Disabled") {
 # Remove existing gateway
 If (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $interface | Remove-NetRoute -Confirm:$false
 }
 # Enable DHCP
 $interface | Set-NetIPInterface -DHCP Enabled
 # Configure the DNS Servers automatically
 $interface | Set-DnsClientServerAddress -ResetServerAddresses
}