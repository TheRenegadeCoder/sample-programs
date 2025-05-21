function Show-Usage() {
    Write-Host "Usage: please provide a string"
    Exit 1
}

function Get-LongestWord([string]$Str) {
    ($Str -split "\s+" | ForEach-Object { $_.Length } | Measure-Object -Maximum).Maximum
}

if ($args.Length -lt 1 -or -not $args[0]) {
    Show-Usage
}

Write-Host (Get-LongestWord $args[0])
