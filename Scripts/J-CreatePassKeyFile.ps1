# Creating a Key File and Password File

# Creating KEY File:
$Key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
$Key | Out-File C:\J\j.key

# Creating Password File:
(Get-Credential).Password | ConvertFrom-SecureString -key (Get-Content C:\J\j.key) | Set-Content "C:\J\j.txt"



