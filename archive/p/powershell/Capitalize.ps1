function Show-Usage() {
    Write-Host "Usage: please provide a string"
    Exit 1
}

function Get-Capitalize([string]$Str) {
    ([string]$Str[0]).ToUpper() + (-join $Str[1..$Str.Length])
}

if ($args.Length -lt 1 -or -not $args[0]) {
    Show-Usage
}

Write-Host (Get-Capitalize $args[0])
