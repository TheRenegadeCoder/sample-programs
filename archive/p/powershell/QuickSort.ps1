function Show-Usage() {
    Write-Host 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

# Source: https://en.wikipedia.org/wiki/Quicksort#Lomuto_partition_scheme
function Invoke-QuickSort([array]$Values) {
    Invoke-QuickSortRec $Values 0 ($Values.Length - 1)
}

function Invoke-QuickSortRec([array]$Values, [int]$Lo, [int]$Hi) {
    if ($Lo -ge 0 -and $Lo -le $Hi) {
        # Partition array and get pivot value
        $p = Invoke-Partition $Values $Lo $Hi

        # Sort left side of partition
        Invoke-QuickSortRec $Values $Lo ($p - 1)

        # Sort right side of partition
        Invoke-QuickSortRec $Values ($p + 1) $Hi
    }
}

function Invoke-Partition([array]$Values, [int]$Lo, [int]$Hi) {
    # Choose the last element as the pivot
    $pivot = $Values[$Hi]

    # Temporary pivot index
    $i = $Lo

    for ($j = $Lo; $j -le ($Hi - 1); $j++) {
        # If the current element is less than or equal to the pivot,
        if ($Values[$j] -le $pivot) {
            # Swap the current element with the element at the temporary pivot index
            $Values[$i], $Values[$j] = $Values[$j], $Values[$i]

            # Move the temporary pivot index forward
            $i++
        }
    }

    # Swap the pivot with the last element
    $Values[$i], $Values[$Hi] = $Values[$Hi], $Values[$i]

    # Return pivot index
    $i
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

Invoke-QuickSort $values
Write-Output ($values -join ', ')
