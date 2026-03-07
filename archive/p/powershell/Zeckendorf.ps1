function Show-Usage() {
    Write-Host "Usage: please input a non-negative integer"
    Exit 1
}

function Get-Fibonacci-Values([int]$Value) {
    $a = 1
    $b = 2
    while ($a -le $Value) {
        $a
        $a, $b = $b, ($a + $b)
    }
}

function Get-Zeckendorf-Values([int]$Value) {
    $fibs = Get-Fibonacci-Values($Value)
    $n = $fibs.Length - 1
    while ($n -ge 0 -and $Value -gt 0) {
        $f = $fibs[$n]
        if ($Value -ge $f) {
            $f
            $Value -= $f
            $n -= 2
        } else {
            $n--
        }
    }
}

if ($args.Length -lt 1) {
    Show-Usage
}

try {
    $value = [int]::Parse($args[0])
} catch {
    Show-Usage
}

if ($value -lt 0) {
    Show-Usage
}

$values = Get-Zeckendorf-Values($value)
Write-Host ($values -join ', ')
