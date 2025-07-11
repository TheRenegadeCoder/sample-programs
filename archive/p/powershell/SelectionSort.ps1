function Show-Usage() {
    Write-Host 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

# Source: https://en.wikipedia.org/wiki/Selection_sort#Implementations
function Invoke-SelectionSort([array]$Values) {
    $n = $Values.Length
    for ($i = 0; $i -lt ($n - 1); $i++) {
        $jMin = $i
        for ($j = $i + 1; $j -lt $n; $j++) {
            if ($Values[$j] -lt $Values[$jMin]) {
                $jMin = $j
            }
        }

        if ($jMin -ne $i) {
            $Values[$i], $Values[$jMin] = $Values[$jMin], $Values[$i]
        }
    }
}

if ($args.Length -lt 1) {
    Show-Usage
}

try {
    $values = Parse-IntList $args[0]
    if ($values.Length -lt 2) {
        Show-Usage
    }
} catch {
    Show-Usage
}

Invoke-SelectionSort $values
Write-Host ($values -join ', ')
