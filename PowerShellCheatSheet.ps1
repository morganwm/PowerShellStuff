#For looking for commandlets
Get-Command

#search the commands
Get-Command -verb "get"
Get-Command -Noun "service"

#Use to get the documentation for a commandlet
Get-Help Get-Command
#                    -examples
#                    -detailed
#                    -full
# some commands support -?



# File Manipulation
# Lists all folders and files in the current path
Get-ChildItem
# Change the director
Set-Location C:\code\Gits

# Logical Operators
# -gt greater than
# -lt less than
# -ge greater than or equal to
# -le less than or equal to
# see more: https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_logical_operators

# Looping
Get-ChildItem | Where-Object { $_.Length -lt 100kb } | Sort-Object Length
$i = 1
while ($i -le 5){
    $i = $i + 1;
}