function Show-Usage() {
    Write-Host "Usage: please input a number"
    Exit 1
}

function Test-IsEven([int]$Value) {
    $Value % 2 -eq 0
}

if ($args.Length -lt 1) {
    Show-Usage
}

try {
    $Value = [int]::Parse($args[0])
} catch {
    Show-Usage
}

Write-Host ((Test-IsEven $Value) ? "Even" : "Odd")
