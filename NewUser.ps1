## New user script

$FirstName = Read-Host 'What is the first name of the person'
$Surname = Read-Host 'What is the surname'
$Domain = '@fairtrade.org.uk'
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
    $Path = "OU=CFO,OU=Ibex House Users,DC=fairtrade,DC=org,DC=uk"
}
elseif ($Directorate -eq "B") {
    $Path = "OU=Impact,OU=Ibex House Users,DC=fairtrade,DC=org,DC=uk"
}
elseif ($Directorate -eq "C") {
    $Path = "OU=Commercial,OU=Ibex House Users,DC=fairtrade,DC=org,DC=uk"
}
elseif ($Directorate -eq "D") {
    $Path = "OU=Public Engagement,OU=Ibex House Users,DC=fairtrade,DC=org,DC=uk"
}
elseif ($Directorate -eq "E") {
    $Path = "OU=Leadership Team,OU=Ibex House Users,DC=fairtrade,DC=org,DC=uk"
}
elseif ($Directorate -eq "F") {
    $Path = "OU=Volunteers,OU=Ibex House Users - NonFF,DC=fairtrade,DC=org,DC=uk"
}

New-ADUser -Name $FullName -GivenName $FirstName -Surname $Surname -SamAccountName "$Username" -UserPrincipalName $EmailAddress -DisplayName $Displayname -Path $Path -AccountPassword(Read-Host -AsSecureString "Type Password for User") -Enabled $true

Set-ADUser $Username -Add @{ProxyAddresses="smtp:$EmailAddress"} -ScriptPath 7windows.bat

md \\olympus\data\FFUserFolders\$Username

$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule("$username","FullControl","Allow")
$Acl.SetAccessRule($Ar)
Set-Acl "\\olympus\data\FFUserFolders\$Username" $Acl

Write-Host = 'The account is now created. Add user to relevant security groups.'
Write-Host = 'Creating Office 365 account and assigning license'

Set-MsolUserLicense -UserPrincipalName $EmailAddress -AddLicenses "fairtradeuk:STANDARDWOFFPACK"
Set-MsolUserLicense -UserPrincipalName $EmailAddress -AddLicenses "fairtradeuk:ADALLOM_O365"
