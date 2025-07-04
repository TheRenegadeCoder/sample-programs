function Show-Usage() {
    Write-Host "Usage: please provide a string"
    Exit 1
}

function Invoke-RemoveAllWhitespace([string]$Str) {
    $Str -replace "\s", ""
}

if ($args.Length -lt 1 -or -not $args[0]) {
    Show-Usage
}

Write-Output (Invoke-RemoveAllWhitespace $args[0])
