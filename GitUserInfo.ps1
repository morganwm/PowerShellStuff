[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 



#Git Function
function Set-UserInfo ( [string] $N, [string] $E) {
    git config --global --unset user.name
    git config --global --unset user.email
    git config --global --replace user.name "$N"
    git config --global --replace user.email "$E"
}



#BUild Form
$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Git User Info"
$objForm.Size = New-Object System.Drawing.Size(300,220) 
$objForm.StartPosition = "CenterScreen"

#set Key actions
$objForm.KeyPreview = $True
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
    {$x=$objTextBox.Text;$objForm.Close()}})
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
    {$objForm.Close()}})


#OK Button
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,140)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({$Name=$objNameTextBox.Text;$Email=$objEmailTextBox.Text;Set-UserInfo $Name $Email;$objForm.Close()})
$objForm.Controls.Add($OKButton)

#Cancel Button
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(150,140)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($CancelButton)

#Name Information
$objNameLabel = New-Object System.Windows.Forms.Label
$objNameLabel.Location = New-Object System.Drawing.Size(10,20) 
$objNameLabel.Size = New-Object System.Drawing.Size(280,20) 
$objNameLabel.Text = "Please Enter Your Name:"
$objForm.Controls.Add($objNameLabel) 

$objNameTextBox = New-Object System.Windows.Forms.TextBox 
$objNameTextBox.Location = New-Object System.Drawing.Size(10,40) 
$objNameTextBox.Size = New-Object System.Drawing.Size(260,20)
$objNameTextBox.Text = git config --global --get "user.name" 
$objForm.Controls.Add($objNameTextBox) 

#Email Information
$objEmailLabel = New-Object System.Windows.Forms.Label
$objEmailLabel.Location = New-Object System.Drawing.Size(10,80) 
$objEmailLabel.Size = New-Object System.Drawing.Size(280,20) 
$objEmailLabel.Text = "Please Enter Your Email:"
$objForm.Controls.Add($objEmailLabel) 

$objEmailTextBox = New-Object System.Windows.Forms.TextBox 
$objEmailTextBox.Location = New-Object System.Drawing.Size(10,100) 
$objEmailTextBox.Size = New-Object System.Drawing.Size(260,20)
$objEmailTextBox.Text = git config --global --get "user.email"
$objForm.Controls.Add($objEmailTextBox) 


#Display
$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()