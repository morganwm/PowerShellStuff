Add-Type -AssemblyName System.DirectoryServices.AccountManagement

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
 
$Domain = $env:USERDOMAIN
$ct = [System.DirectoryServices.AccountManagement.ContextType]::Domain
$pc = New-Object System.DirectoryServices.AccountManagement.PrincipalContext $ct,$Domain

#Git Function
function Check-ValidCredentials ( [string] $UserName, [string] $Password) {
    
    $auth = $pc.ValidateCredentials($UserName,$Password)
    return $auth
}
 

#BUild Form
$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Authenticate Credentials"
$objForm.Size = New-Object System.Drawing.Size(300,250) 
$objForm.StartPosition = "CenterScreen"

#OK Button
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,140)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({$objValidLabel.Text="";$UserName=$objUserNameTextBox.Text;$Password=$objPasswordTextBox.Text;$valid=Check-ValidCredentials $UserName $Password;$objValidLabel.Text=$valid})
$objForm.Controls.Add($OKButton)

#Cancel Button
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(150,140)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($CancelButton)


#UserName Information
$objUserNameLabel = New-Object System.Windows.Forms.Label
$objUserNameLabel.Location = New-Object System.Drawing.Size(10,20) 
$objUserNameLabel.Size = New-Object System.Drawing.Size(280,20) 
$objUserNameLabel.Text = "Please Enter Username:"
$objForm.Controls.Add($objUserNameLabel) 

$objUserNameTextBox = New-Object System.Windows.Forms.TextBox 
$objUserNameTextBox.Location = New-Object System.Drawing.Size(10,40) 
$objUserNameTextBox.Size = New-Object System.Drawing.Size(260,20)
$objForm.Controls.Add($objUserNameTextBox) 

#Password Information
$objPasswordLabel = New-Object System.Windows.Forms.Label
$objPasswordLabel.Location = New-Object System.Drawing.Size(10,80) 
$objPasswordLabel.Size = New-Object System.Drawing.Size(280,20) 
$objPasswordLabel.Text = "Please Your Password:"
$objForm.Controls.Add($objPasswordLabel) 

$objPasswordTextBox = New-Object System.Windows.Forms.TextBox 
$objPasswordTextBox.Location = New-Object System.Drawing.Size(10,100) 
$objPasswordTextBox.Size = New-Object System.Drawing.Size(260,20)
$objForm.Controls.Add($objPasswordTextBox) 

#Information Validation Info
$objValidLabel = New-Object System.Windows.Forms.Label
$objValidLabel.Location = New-Object System.Drawing.Size(140,170) 
$objValidLabel.Size = New-Object System.Drawing.Size(280,20) 
$objValidLabel.Text = ""
$objForm.Controls.Add($objValidLabel) 


#Display
$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()