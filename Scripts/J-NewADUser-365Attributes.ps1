<#
Interactive Script to create New Active Directory User with attributes for 365.
Written by Jeni Shinder.
#>

Import-Module ActiveDirectory

Clear-Host
$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'
$GivName = Read-Host "Please Enter Users First Name (Enter for blank)" 
$SurName = Read-Host "Please Enter Users Last Name (Enter for blank)"
$sAMName = Read-Host "Please Enter Users Login Name (Can't be blank!)"
#$Name = "$GName $SName"
$Login = $sAMName +"@igudhadera.co.il"
$email = $sAMName +"@sviva-sc.org.il"
$ProxAdrMain = "SMTP:$sAMName@sviva-sc.org.il"
$ProxAdr365 = "smtp:$sAMName@igudhadera.mail.onmicrosoft.com"
$ProxAdrOnPrem = "smtp:$sAMName@igudhadera.co.il" 
$TargetAdr =  $sAMName +'@igudhadera.mail.onmicrosoft.com'
$OUp = "CN=Users,DC=igudhadera,DC=co,DC=il"
$Password = '!gud-N3wp@s5'
#User to search for
#$USERNAME = $sAMName

#Declare LocalUser Object
$ObjADUser = $null

 #Check and see if the user already exists in AD
    if (Get-ADUser -F { SamAccountName -eq $sAMName }) {
        
        #Warn if the users already exists
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
    else {
        #User does not exist then proceed to create the new user account
        New-ADUser `
            -SamAccountName $sAMName `
            -UserPrincipalName $Login `
            -Name "$GivName $SurName" `
            -GivenName $GivName `
            -Surname $SurName `
            -Enabled $True `
            -DisplayName $Name `
            -Path $OUp `
            -EmailAddress $email `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -PasswordNeverExpires:$false -ChangePasswordAtLogon:$True
            # Add Custom Attributes for 365
            Set-ADUser $sAMName -add @{ProxyAddresses=$ProxAdrMain,$ProxAdr365,$ProxAdrOnPrem}
            Set-ADUser $sAMName -add @{TargetAddress=$TargetAdr}
            Get-ADUser -Identity $sAMName -Properties proxyaddresses | Select-Object Name, @{L = "ProxyAddresses"; E = { ($_.ProxyAddresses -like 'smtp:*') -join ";"}}
        
        #If this user exists
        Write-Host "The user account $sAMName is created." -ForegroundColor Cyan
}

<#
try {
    Write-Verbose "Searching for $($sAMName) in Activ Directory DataBase"
    $ObjADUser = Get-ADUser $sAMName
    Write-Verbose "User $($sAMName) was found" 
}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException,Microsoft.ActiveDirectory.Management.Commands.GetADUser] {
    "User $($sAMName) was not found" | Write-Warning
}
catch {
    "An unspecifed error occured" | Write-Error
    Exit # Stop Powershell! 
}
#>
#Create the user if it was not found (Example)
<#if (!$ObjADUser) {
    Write-Verbose "Creating User $($sAMName)" #(Example)
	New-ADUser -Name $Name -GivenName $GName -Surname $SName -SamAccountName $sAMName -UserPrincipalName $Login -Path $OUp -AccountPassword(Read-Host -AsSecureString "Input Password") -Enabled $true
	Set-ADUser $sAMName -add @{ProxyAddresses=$ProxAdrMain,$ProxAdr365,$ProxAdrOnPrem}
    Set-ADUser $sAMName -add @{TargeAddresse=$TargetAdr}
    Get-ADUser -Identity $sAMName -Properties proxyaddresses | Select-Object Name, @{L = "ProxyAddresses"; E = { ($_.ProxyAddresses -like 'smtp:*') -join ";"}}

}
#>

