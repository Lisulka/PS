# Get & Set NTFS Permissions via Powershell
gci \\File-Server\Shared-Folder\Some-File.ext   | where {$_.psiscontainer -eq $true} | get-acl | select path,accesstostring | fl

gci \\File-Server\Shared-Folder\ | where {$_.psiscontainer -eq $true} | get-acl | select path,accesstostring | fl

gci \\File-Server\Shared-Folder\'Wildcard*' | where {$_.psiscontainer -eq $true} | get-acl | select path,accesstostring | fl

gci \\File-Server\Shared-Folder\Shared2\Shared3\ | where {$_.psiscontainer -eq $true} | get-acl | select path,accesstostring | fl


$NewAcl = Get-Acl '\\File-Server\Shared-Folder\Some-File.pdf'   #  << Get ACL From
Get-ChildItem -Path "\\File-Server\Shared-Folder\Some Folder" -Recurse -Include "*.*" -Force | Set-Acl -AclObject $NewAcl # <<< Set ACL to

