## New user script

$FirstName = Read-Host 'What is the first name of the person'
$Surname = Read-Host 'What is the surname'
$Domain = '@XXXX'
$EmailAddress = $FirstName + '.' + $Surname + $Domain
$Username = $FirstName + '.' + $Surname
$Fullname = $FirstName + $Surname
$Displayname = $FirstName +  $Surname

$Directorate = Read-Host 'What is the directorate?
A - CFO
B - Impact
C - Commercial
D - Public Engagement
E - LEadership TEam
F - Volunteer'


if ($Directorate -eq "A") {
    $Path = "XXX"
}
elseif ($Directorate -eq "B") {
    $Path = "XXX"
}
elseif ($Directorate -eq "C") {
    $Path = "XXX"
}
elseif ($Directorate -eq "D") {
    $Path = "XXX"
}
elseif ($Directorate -eq "E") {
    $Path = "XXX"
}
elseif ($Directorate -eq "F") {
    $Path = "XXX"
}

New-ADUser -Name $FullName -GivenName $FirstName -Surname $Surname -SamAccountName "$Username" -UserPrincipalName $EmailAddress -DisplayName $Displayname -Path $Path -AccountPassword(Read-Host -AsSecureString "Type Password for User") -Enabled $true

Set-ADUser $Username -Add @{ProxyAddresses="smtp:$EmailAddress"} -ScriptPath 7windows.bat

md \\Serverpath\path\path
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule("$username","FullControl","Allow")
$Acl.SetAccessRule($Ar)
Set-Acl "\\Serverpath\path\path" $Acl

Write-Host = 'The account is now created. Add user to relevant security groups.'
Write-Host = 'Creating Office 365 account and assigning license'

Set-MsolUserLicense -UserPrincipalName $EmailAddress -AddLicenses "domain:STANDARDWOFFPACK"
Set-MsolUserLicense -UserPrincipalName $EmailAddress -AddLicenses "domain:ADALLOM_O365"
