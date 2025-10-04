function Show-Usage() {
    Write-Host "Usage: please input the count of fibonacci numbers to output"
    Exit 1
}

function Show-Fibonacci([int]$Value) {
    if ($Value -gt 0) {
        $A, $B = 0, 1
        1..$Value | ForEach-Object {
            $A, $B = $B, ($A + $B)
            Write-Host "${_}: $A"
        }
    }
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

Show-Fibonacci $Value
