$Path = "C:\Git"
cd $Path

#For each top level folder copy in the .gitignore file
$Repos = ls -Directory .\
$Repos | ForEach-Object{
    Copy-Item -Path .\.gitignore -Destination .\$($_.name)\.gitignore -Force
}

#remove all the TFVC link files
$ChangesetFileNames = ls -Path .\ -Recurse -Include "*.vs*scc"
$ChangesetFileNames | ForEach-Object{
    Remove-Item -Path $_.FullName -Force
}

#cut out the linking info from every solution file
$Solutions = ls -Path .\ -Recurse -Include "*.sln"
$Solutions | ForEach-Object{
    $exists = Select-String -InputObject $_ -Pattern "TeamFoundationVersionControl"
    if ($exists){
        $content = Get-Content -Path $_.FullName
        $newcontent = @()
        $c = 0
        for ($i = $exists.LineNumber - 1; $i -lt $content.Length; $i++){
            $c++
            if ($content[$i] -like "*EndGlobalSection"){
                break
            }
        }
        for ($i = 0; $i -lt $content.Length; $i++){
            if (($i -lt $exists.LineNumber - 1) -or ($i -ge $exists.LineNumber - 1 + $c)){
                $newcontent += $content[$i]
            }
        }
        Set-Content -Path $_.FullName -Value $newcontent -Force
    }
}

#cut out the linking info from every project file
$Projects = ls -Path .\ -Recurse -Include "*.*proj"
$Projects | ForEach-Object{
    $exists = Select-String -InputObject $_ -Pattern "scc"
    if ($exists){
        $content = Get-Content -Path $_.FullName
        $newcontent = @()
        for ($i = 0; $i -lt $content.Length; $i++){
            if ($content[$i] -notlike "*scc*"){
                $newcontent += $content[$i]
            }
        }
        Set-Content -Path $_.FullName -Value $newcontent -Force
    }
}