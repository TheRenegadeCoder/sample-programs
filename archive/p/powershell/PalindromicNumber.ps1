function Show-Usage() {
    Write-Host "Usage: please input a non-negative integer"
    Exit 1
}

function Test-IsPalindromicNumber([int]$Value) {
    $Str = [string]$Value
    $Str -eq -join $Str[$Str.Length..0]
}

if ($args.Length -lt 1) {
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

Write-Host ((Test-IsPalindromicNumber $Value) ? "true" : "false")
