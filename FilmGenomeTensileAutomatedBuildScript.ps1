#Add-Type -AssemblyName System.DirectoryServices.AccountManagement




#get credentials from user for later use 
#$creds = Get-Credential -UserName "SDIRROBOTICSTFS" -Message "Please Enter a Username and Password for Authentication to TFS 2017"



#validate credentials against active directory to ensure they will work
#$Domain = $env:USERDOMAIN
#$ct = [System.DirectoryServices.AccountManagement.ContextType]::Domain
#$pc = New-Object System.DirectoryServices.AccountManagement.PrincipalContext $ct,$Domain
#$valid = $pc.ValidateCredentials($creds.UserName,$creds.GetNetworkCredential().Password)

if (-not $valid){
    
    #$Override = (New-Object -ComObject Wscript.Shell).Popup("These Credentials Are not in Active Directory! If you are sure they will authenticate to TFS click 'Ok'",0,"Done",0x1)

    if ($Override -ne 1){
        #Write-Host "These Credentials Are not in Active Directory and the User has chosen to Exit the Script. Please Use Credentials that are Valid for access."
        #return
    } 
    
} else {
    #Write-Host "These Credentials Are in Active Directory, and will hopefully authenticate to TFS."
}



#check for git
Write-Host "Checking for Git install..."
$gitvs = git --version
$gitinst = $gitvs -like "git version *"
if (-not $gitinst){
    Write-Host "git is not currently installed"
    [System.Windows.Forms.MessageBox]::Show("Error" , "No Git Installers Found. Please Install Git!")
    return


    #extra code for if I ever feel like trying to automate git install
    #good sample for stuff though

    Write-Host "git is not currently installed, checking for the installer..."
    $localuserdirs = ls "C:\Users\" .\ -Include "u*"
    $gitexefiles = @()
    $localuserdirs | ForEach-Object{
        $dirstring = "C:\Users\" + $_.Name + "\Downloads\"
        $gitexefiles += ls $dirstring -Filter "Git*.exe"
    }

    if (-not $gitexefiles){
        Write-Host "No Git Installers Found"
        [System.Windows.Forms.MessageBox]::Show("No Git Installers Found. Please Install Git!" , "Error")
        return
    }

    Write-Host "No Git Installer(s) Found"
    Write-Host "Determining Most Recently Installed"
}

#Take Care of the  implementer software
$implementerREPOURL = "https://rndtfs.intranet.dow.com/dow/IR/_git/FilmGenomeTensileImplementer"
$implementerpath = "C:\Code"
$implementerpathexists = Test-Path $implementerpath
if (-not $implementerpathexists){
    Write-Host "Implementer Path " + $implementerpath + " Does not Exist, making it..."
    New-Item $implementerpath -type directory
}
cd $implementerpath
git clone $implementerREPOURL

#Take care of the EPSON code
$EPSONREPOURL = "https://rndtfs.intranet.dow.com/dow/IR/_git/FilmGenomeTensileEPSON"
$epsonpath = "C:\EpsonRC70\projects"
$epsonpathexists = Test-Path $epsonpath
if (-not $epsonpathexists){
    Write-Host "EPSON Path " + $epsonpath + " Does not Exist."
    [System.Windows.Forms.MessageBox]::Show("EPSON Path (" + $epsonpath + ") was not found, this means the Correct Version RC+ Software Has not been Installed. Please install this first." , "Error")
    return
}
cd $epsonpath
git clone $EPSONREPOURL

#Take care of the Aerotech code
$AerotechREPOURL = "https://rndtfs.intranet.dow.com/dow/IR/_git/FilmGenomeTensileAerotech"
$aerotechpath = "C:\Users\Public\Documents\Aerotech\Ensemble\User Files"
$aerotechpathexists = Test-Path $aerotechpath
if (-not $aerotechpathexists){
    Write-Host "EPSON Path " + $aerotechpath + " Does not Exist."
    [System.Windows.Forms.MessageBox]::Show("Aerotech Path (" + $aerotechpath + ") was not found, this means the Correct Version Ensemble Software Has not been Installed. Please install this first." , "Error")
    return
}
cd $aerotechpath
cd $AerotechREPOURL

#Take care of SICK
$SICKRepo = "SICK Safety"
$SICKREPOURL = "https://rndtfs.intranet.dow.com/dow/IR/_git/FilmGenomeTensileSICK"
cd C:\
git clone $SICKREPOURL
Rename-Item C:\FilmGenomeTensileSICK $SICKRepo
