#Command to kick off the setup script. Run in a 
#(mkdir c:\drop & cd c:\drop && curl -o cascade.ps1 https://raw.githubusercontent.com/IGL-Nick/RepoReplicator/main/cascade.ps1 && powershell.exe -executionpolicy bypass -noprofile -file .\cascade.ps1)
cls
#SCRIPT ENTRY

$workingDirectory = "c:\drop"

try{
    $statusGit = git version
    Write-Host 'Git is installed'
}
catch{
    Write-Host 'Git is not installed. Installing...'

    Try{
        mkdir "$workingDirectory\GitInstall"
        Write-Host 'Creating working directory'
    }
    catch{
        Write-Host 'Working directory exists'
    }

    cmd /c "cd $workingDirectory\GitInstall && curl -o Install-Git.ps1 https://raw.githubusercontent.com/IGL-Nick/RepoReplicator/main/Core/Install-Git.ps1)"
    cmd /c "powershell.exe -executionpolicy bypass -noprofile -file $workingDirectory\GitInstall\Install-Git.ps1)"
}



