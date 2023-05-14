# LockedOut ADAccounts handeling

#Search the AD
Search-AdAccount -LockedOut

# Unlock Account by username
Unlock-ADAccount -Identity 'lockeduser'

# Unlock any found locked acc
Search-ADAccount -LockedOut | Unlock-ADAccount


# Find the PDCe Role Holder (All password authentication will come to this DC holding the PDCe role so it is always the best place to check)
$pdce = (Get-ADDomain).PDCEmulator


# Scouring the Event Log for Lockouts
Get-WinEvent -ComputerName $pdce -FilterHashTable @{'LogName' ='Security';'Id' = 4740}

# Parsing the Username and Location
$filter = @{'LogName' = 'Security';'Id' = 4740}
$events = Get-WinEvent -ComputerName $pdce -FilterHashTable $filter
$events | Select-Object @{'Name' ='UserName'; Expression={$_.Properties[0]}}, @{'Name' ='ComputerName';Expression={$_.Properties[1]}}



