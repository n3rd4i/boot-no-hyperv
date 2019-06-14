$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

$CurrentUUID = [regex]::match((iex $cmdGetUUID), $reCurrent).Groups[1].Value
$NoHyperVUUID = Get-EnvironmentVariable -Name $BootNoHyperVUUID -Scope 'User'

if ($NoHyperVUUID -eq $CurrentUUID) {
	Write-Host 'Boot-No-HyperV UUID == This Boot UUID!'
	Write-Host 'Restart with different Boot UUID than No-HyperV!'
	exit 1
}
else {
	bcdedit /delete "$NoHyperVUUID"
	Uninstall-ChocolateyEnvironmentVariable -VariableName $BootNoHyperVUUID
	Uninstall-ChocolateyEnvironmentVariable -VariableName $BootCurrentUUID
}
