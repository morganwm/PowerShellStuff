Add-Type -AssemblyName System.DirectoryServices.AccountManagement
 
$UserName= "SDIRROBOTICSTFS"
$Password=''
$Domain = $env:USERDOMAIN
 
$ct = [System.DirectoryServices.AccountManagement.ContextType]::Domain
$pc = New-Object System.DirectoryServices.AccountManagement.PrincipalContext $ct,$Domain
$pc.ValidateCredentials($UserName,$Password)
