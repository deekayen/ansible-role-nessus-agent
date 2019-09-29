# Custom value: [[CustomValue]]
$ErrorActionPreference = 'Stop'; # stop on all errors


$packageName  = 'tenable-nessus-agent'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'NessusAgent-7.4.3-x64.msi'

$pp = Get-PackageParameters

if (!$pp.NessusServer) { $pp.NessusServer = 'cloud.tenable.com' }
if (!$pp.NessusGroups) { $pp.NessusGroups = '' }
if (!$pp.NessusKey) { $pp.NessusKey = '' }

$packageArgs = @{
  packageName   = $packageName
  file          = $fileLocation
  fileType      = 'msi' #only one of these: exe, msi, msu

  #EXE
  silentArgs    = "/qn NESSUS_GROUPS='$($pp.NessusGroups)' NESSUS_SERVER=$($pp.NessusServer) NESSUS_KEY=$($pp.NessusKey)"
    validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs
