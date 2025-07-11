function Show-Usage() {
    Write-Host 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

# https://en.wikipedia.org/wiki/Insertion_sort#Algorithm
function Invoke-InsertionSort([int[]]$Values) {
    $n = $Values.Length
    $i = 1
    for ($i = 1; $i -lt $n; $i++) {
        $x = $Values[$i]
        $j = $i
        while ($j -gt 0 -and $Values[$j - 1] -gt $x) {
            $Values[$j] = $Values[$j - 1]
            $j--
        }

        $Values[$j] = $x
    }

    $Values
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

$sortedValues = Invoke-InsertionSort $values
Write-Host ($sortedValues -join ', ')
