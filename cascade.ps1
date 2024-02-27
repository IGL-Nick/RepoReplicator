#Command to kick off the setup script. Run in a 
#(mkdir c:\drop & cd c:\drop && curl -o cascade.ps1 https://raw.githubusercontent.com/IGL-Nick/RepoReplicator/main/cascade.ps1 && powershell.exe -executionpolicy bypass -noprofile -file .\cascade.ps1)

#check for elevated permissions
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe -WindowStyle Hidden "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}


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

    Invoke-WebRequest 'https://raw.githubusercontent.com/IGL-Nick/RepoReplicator/main/Core/Install-Git.ps1' -OutFile "$workingDirectory/GitInstall/Install-Git.ps1"
    Start-Process -FilePath powershell.exe -ArgumentList "-executionpolicy bypass -noprofile -file $workingDirectory\GitInstall\Install-Git.ps1" -Wait
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}
