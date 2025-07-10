function Show-Usage() {
    Write-Host 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

# Source: https://en.wikipedia.org/wiki/Bubble_sort#Optimizing_bubble_sort
function Invoke-BubbleSort([int[]]$Values) {
    $n = $Values.Length
    do {
        $newN = 0
        for ($i = 1; $i -lt $n; $i++) {
            if ($Values[$i - 1] -gt $Values[$i]) {
                $Values[$i - 1], $Values[$i] = $Values[$i], $Values[$i - 1]
                $newN = $i
            }
        }

        $n = $newN
    } while ($n -gt 1)

    $Values
}

if ($args.Length -lt 1 -or -not $args[0]) {
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

$SortedValues = Invoke-BubbleSort $Values
Write-Output ($SortedValues -join ', ')
