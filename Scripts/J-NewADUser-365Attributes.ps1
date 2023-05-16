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
$Login = $sAMName +"@your-org-mail.com"
$email = $sAMName +"@your-org-mail.com"
$ProxAdrMain = "SMTP:$sAMName@sviva-sc.org.il"
$ProxAdr365 = "smtp:$sAMName@your-org-mail.mail.onmicrosoft.com"
$ProxAdrOnPrem = "smtp:$sAMName@your-org-mail.com" 
$TargetAdr =  $sAMName +'@your-org-mail.mail.onmicrosoft.com'
$OUp = "CN=Users,DC=your-org,DC=domain,DC=com"
$Password = 'SomePassword' # Better to use key file for that!
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



