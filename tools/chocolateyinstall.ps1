$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

## Get current UUID, preserve for reinstall
$uuid = [regex]::match((iex $cmdGetUUID), $reCurrent).Groups[1].Value
Install-ChocolateyEnvironmentVariable $BootCurrentUUID "$uuid"

## Duplicate target (No Hyper-V) UUID
$re = '(\{(?:\w+\-?){5}\})'
$cmd = "bcdedit /copy '{current}' /d 'Disable Hyper-V'"
$uuid = (iex $cmd | select-string -pattern $re).Matches[0].Value

## Customize it
bcdedit /set "$uuid" hypervisorlaunchtype off

## Set as default and remove timeout
bcdedit /default "$uuid"
bcdedit /timeout 0

## Preserve target uuid in env for uninstall
Install-ChocolateyEnvironmentVariable $BootNoHyperVUUID "$uuid"
