$Romans = @{
    M = 1000
    D = 500
    C = 100
    L = 50
    X = 10
    V = 5
    I = 1
}

function Show-Usage() {
    Write-Host 'Usage: please provide a string of roman numerals'
    Exit 1
}

function Show-Error() {
    Write-Host 'Error: invalid string of roman numerals'
    Exit 1
}

function RomanNumeral([string]$Str) {
    $total = 0
    $prevValue = 0
    foreach ($ch in $Str.ToCharArray()) {
        $value = $Romans[[string]$ch]
        if (-not $value) {
            $total = -1
            break
        }

        $total += $value
        if ($prevValue -gt 0 -and $value -gt $prevValue) {
            $total -= 2 * $prevValue
            $prevValue = 0
        } else {
            $prevValue = $value
        }
    }

    $total
}

if ($args.Length -lt 1) {
    Show-Usage
}

$result = RomanNumeral $args[0]
if ($result -lt 0) {
    Show-Error
}

Write-Output $result
