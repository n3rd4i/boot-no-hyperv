$ErrorActionPreference = 'Stop'; # stop on all errors

$re = 'identifier\s+(\{(?:\w+\-?){5}\})'
$cmd = "bcdedit /enum '{current}' /v"
$uuid = [regex]::match((iex $cmd), $re).Groups[1].Value
Install-ChocolateyEnvironmentVariable "BootCurrentUUID" "$uuid"

$re = '(\{(?:\w+\-?){5}\})'
$cmd = "bcdedit /copy '{current}' /d 'Disable Hyper-V'"
$uuid = (iex $cmd | select-string -pattern $re).Matches[0].Value

bcdedit /set "$uuid" hypervisorlaunchtype off
bcdedit /default "$uuid"
bcdedit /timeout 0

Install-ChocolateyEnvironmentVariable "BootNoHyperVUUID" "$uuid"
