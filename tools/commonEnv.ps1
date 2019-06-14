$BootCurrentUUID = "BootCurrentUUID"
$BootNoHyperVUUID = "BootNoHyperVUUID"

$reCurrent = 'identifier\s+(\{(?:\w+\-?){5}\})'
$cmdGetUUID = "bcdedit /enum '{current}' /v"
