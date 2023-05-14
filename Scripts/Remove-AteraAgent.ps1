#If you get error regarding the next commands, please update powershell because Remove-Service was entroduced in PS v6!
# To check PS version run -> Get-Host | Select-Object Version
#iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"


#Kill and Remove Related Services
Get-Service | Where-Object {$_.ServiceName -Like "Splash*"} | Stop-Service -force | Remove-Service
Get-Service | Where-Object {$_.ServiceName -Like "SSU*"} | Stop-Service -force | Remove-Service
Get-Service | Where-Object {$_.ServiceName -Like "Atera*"} | Stop-Service -force | Remove-Service

#Kill Ticketing Agent and System Tray Process
Get-Process | Where-Object {$_.ProcessName -Like "Ticket*"} | Stop-Process -force

#Remove Ticketing Agent from each User's AppData Folder
$users = Get-ChildItem C:\Users.
foreach ($user in $users){
$folder = "C:\users\" + $user + "\AppData\Local\Temp\TicketingAgentPackage"
Remove-Item $folder -Recurse -Force -ErrorAction silentlycontinue
}

#Remove Atera Program Files Folders
Remove-Item "C:\Program Files (x86)\ATERA Networks" -Recurse -Force -ErrorAction silentlycontinue
Remove-Item "C:\Program Files\ATERA Networks" -Recurse -Force -ErrorAction silentlycontinue

#Removes Registry for Software and Autorun
Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "AlphaHelpdeskAgent"
Remove-Item -Path 'HKLM\SOFTWARE\ATERA Networks'

#Uninstall Splashtop Streamer
$app = Get-CimInstance -class Win32_Product -filter "Name = 'Splashtop Streamer'"
$app.Uninstall()