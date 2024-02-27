$workingDirectory = 'c:\drop\GitInstall'

Try{mkdir $workingDirectory
    Write-Host 'Creating working directory'
}
catch{
    Write-Host 'Working directory exists'
}

# get latest download url for git-for-windows 64-bit exe
$git_url = "https://api.github.com/repos/git-for-windows/git/releases/latest"


$asset = Invoke-RestMethod -Method Get -Uri $git_url | % assets | where name -like "*64-bit.exe"
# download installer
$installer = "$workingDirectory\$($asset.name)"
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $installer

$git_install_inf = "$workingDirectory\git_install.inf"

New-Item $git_install_inf -ItemType File -force -Value "[Setup]
Lang=default
Dir=C:\Program Files\Git
Group=Git
NoIcons=0
SetupType=default
Components=ext,ext\shellhere,ext\guihere,gitlfs,assoc,autoupdate
Tasks=
EditorOption=VIM
CustomEditorPath=
PathOption=Cmd
SSHOption=OpenSSH
TortoiseOption=false
CURLOption=WinSSL
CRLFOption=LFOnly
BashTerminalOption=ConHost
PerformanceTweaksFSCache=Enabled
UseCredentialManager=Enabled
EnableSymlinks=Disabled
EnableBuiltinInteractiveAdd=Disabled"
  
# run installer
   
$install_args = "/SP- /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /NORESTART /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /LOADINF=""$git_install_inf"""
Start-Process -FilePath $installer -ArgumentList $install_args -Wait

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

