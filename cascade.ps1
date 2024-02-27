#(mkdir c:\drop & cd c:\drop && curl -o cascade.ps1 https://raw.githubusercontent.com/IGL-Nick/RepoReplicator/main/cascade.ps1 && powershell.exe -executionpolicy bypass -noprofile -file .\cascade.ps1)

try{
git version

}
catch{
Git is not installed. please install git
}
pause
