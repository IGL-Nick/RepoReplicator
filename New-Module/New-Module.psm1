﻿Function New-Module{

$Path = '\KPHRepo'

$moduleName = Read-Host 'Please enter the name of the new module'
$scriptLocation = "Scripts\$moduleName.ps1"
$scriptDescription = Read-Host 'Please enter a description'

If(!(Test-Path "$Path\$moduleName")){
    New-Item "$Path\$moduleName" -ItemType Directory | Out-Null
}

$HS = @"
Function $moduleName{
$existingCode
}
"@

If(!(Test-Path "$Path\$moduleName\$moduleName.psm1")){
    $HS | Out-File "$Path\$moduleName\$moduleName.psm1"
}




#New Module
$applicationName = $moduleName
$functionDescription = $scriptDescription

New-ModuleManifest -Path "$Path\$applicationName\$applicationName.psd1" -RootModule "$applicationName.psm1" -Description $functionDescription -Author 'Nick Nieto' -FunctionsToExport $applicationName -AliasesToExport $applicationName -CompanyName 'KPH' -ModuleVersion '1.0'
Publish-Module -Path "$path\$modulename" -Repository KPHRepo
}

