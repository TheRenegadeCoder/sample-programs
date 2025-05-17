function Show-Usage() {
    Write-Host "Usage: please input a non-negative integer"
    Exit 1
}

function Test-IsPrime([int]$Value) {
    if ($Value -lt 2 -or ($Value -ne 2 -and $Value % 2 -eq 0)) {
        return $false
    }

    $Q = [Math]::Floor([Math]::Sqrt($Value))
    for ($X = 3; $X -le $Q; $X += 2) {
        if ($Value % $X -eq 0) {
            return $false
        }
    }

    return $true
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

Write-Host ((Test-IsPrime $Value) ? "prime" : "composite")
