##########################################
#Interactive ADSync by Jeni.S aka Lisulka#
##########################################
<#
|----/Delta sync cycle includes the following steps:
|--Delta import on all Connectors
|--Delta sync on all Connectors
|--Export on all Connectors/
|
|------/Full sync cycle includes the following steps:
|--Full Import on all Connectors
|--Full Sync on all Connectors
|--Export on all Connectors/
#>

Import-Module ADSync
# Write-HostCenter function - was took from stackoverflow ;)
function Write-HostCenter { param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $Message) -ForegroundColor Yellow }
function Show-Menu
{
     param (

           [string]$Title = 'Choose ADSyncSyncCycle Type'

     )
     #cls
     Write-HostCenter " $Title " -ForegroundColor Green
     Write-HostCenter " > '1'     Delta Sync        '1' < " -ForegroundColor Cyan
     Write-HostCenter " > '2'    Initial Sync       '2' < " -ForegroundColor Magenta
     Write-HostCenter " > '3'  Scheduler Conf.View  '3' < " -ForegroundColor Yellow
     Write-HostCenter " > 'Q'       Quit            'Q' < " -ForegroundColor Red


}
do
{
     
     Show-Menu
     $input = Read-Host "               Please make a selection              "
     switch ($input)
          {
           '1' {          date 
                '         Runing Delta Sync...' 
                          Start-ADSyncSyncCycle -PolicyType Delta 
                 
         } '2' {          date 
                '         Runing Initial Sync...' 
                          Start-ADSyncSyncCycle -PolicyType Initial
                
         } '3' {          date 
                '         Showing Scheduler Configuration:'
                          Get-ADSyncScheduler
                
         } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
