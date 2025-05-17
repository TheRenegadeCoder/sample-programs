function Show-Usage() {
    Write-Host "Usage: please input a non-negative integer"
    Exit 1
}

function Get-Factorial([int]$Value) {
    $Product = 1
    if ($Value -gt 0) {
        1..$Value | ForEach-Object { $Product *= $_ }
    }

    $Product
}

if ($args.Length -lt 1 -or -not $args[0]) {
    Show-Usage
}

try {
    $Value = [int]::Parse($args[0])
} catch {
    Show-Usage
}

if ($Value -lt 0) {
    Show-Usage
}

Write-Host (Get-Factorial $Value)
