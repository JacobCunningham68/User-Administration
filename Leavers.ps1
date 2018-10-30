
# Script for leavers. It does in this order: Moves to leavers 2018 OU, Disables AD account, removes all group membership, sets mailbox to shared and removes the license. Written by JC. Who we know and love.
# Ensure you run connect.ps1 before running this otherwise PS won't be able to connect to Office 365. Make sure you are connected to both MSOL and Office 365 account.

write-host "Have you fixed the permissions issue? Press any key to continue"
pause

$UPN = Read-Host 'Who is the email address of the user you are removing'
$Username = Read-host 'What is the username'

Get-ADUser $Username| Move-ADObject -TargetPath 'OU=XXX,OU=XXX,DC=XXX,DC=XX,DC=XX'
Disable-ADAccount -Identity $Username

Get-ADUser -Identity $Username -Properties MemberOf | ForEach-Object {
$_.MemberOf | Remove-ADGroupMember -Members $_.DistinguishedName -Confirm:$false
}

Set-Mailbox $UPN -Type Shared


Set-MsolUserLicense -UserPrincipalName $UPN -RemoveLicenses "DOMAIN:STANDARDWOFFPACK"
Set-MsolUserLicense -UserPrincipalName $UPN -RemoveLicenses "DOMAIN:ADALLOM_O365"
