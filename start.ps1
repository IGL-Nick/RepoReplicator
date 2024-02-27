#powershell.exe -executionpolicy bypass -noprofile -file .\EmployeePortal\employeeportal.ps1
$repoDirectory = "\\192.168.X.X\programs"
$repoName = "NickRepo"
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Confirm:$false

cls
Write-Host 'Script Starting'

$Path = '$repoDirectory\EmployeePortal\$repoName'

Function Connect-Repo {
    Write-Host 'Connecting to Repository'
    $REPO = @{
      Name               = $repoName 
      SourceLocation     = $Path
      PublishLocation    = $Path
      InstallationPolicy = 'Trusted'
    }
    Register-PSRepository @REPO
}

if(!((Get-PSRepository).name -like "*$repoName*")){Connect-Repo}


$modules = (Get-ChildItem $path | ?{$_.name -notlike '*nupkg*'}).name



ForEach($module in $modules){
    Import-Module -Name "$path\$module" 
}
cls


Write-Host 'What can I help with?';''
Write-Host 'Use /? for help, q or quit to exit'

$breakOut = 0

While($breakOut -eq 0){
    #Read
    $userInput = Read-Host 'CONSOLE'

    
    if(($userInput -eq 'q') -or ($userInput -like '*quit*')){
        $breakOut = 1
        break
    }
    
    if($userInput -like '/?'){
        '';'--Available Commands--'    
        $modules
        ''
    }
    else{
        if($userInput -ne $null){
            Invoke-Expression $userInput
        }
    }

}

