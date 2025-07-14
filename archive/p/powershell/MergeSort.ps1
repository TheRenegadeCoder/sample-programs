function Show-Usage() {
    Write-Host 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

# Source: https://en.wikipedia.org/wiki/Merge_sort#Top-down_implementation
function Invoke-MergeSort([array]$A) {
    # Create temporary work array and copy the values into it
    $B = @($A | ForEach-Object { $_ })

    # Run the recursive merge sort
    Invoke-MergeSortRec $A 0 $A.Length $B
}

function Invoke-MergeSortRec([array]$B, [int]$Lo, [int]$Hi, [array]$A) {
    # Only sort if enough values
    if (($Hi - $Lo) -gt 1) {
        # Get midpoint
        $Mid = ($Hi + $Lo) -shr 1

        # Sort the left half (low to midpoint - 1) from A into B
        Invoke-MergeSortRec $A $Lo $Mid $B

        # Sort the right half (midpoint to high - 1) from A into B
        Invoke-MergeSortRec $A $Mid $Hi $B

        # Merge the two halves from B into A
        Invoke-Merge $B $Lo $Mid $Hi $A
    }
}

function Invoke-Merge([array]$B, [int]$Lo, [int]$Mid, [int]$Hi, [array]$A) {
    $i = $Lo
    $j = $Mid

    # While there are elements in the left or right
    for ($k = $Lo; $k -lt $Hi; $k++) {
        # Copy the side that has the next largest value (or next available value if
        # out of values) from the A into B
        if ($i -lt $Mid -and ($j -ge $Hi -or $A[$i] -le $A[$j])) {
            $B[$k] = $A[$i]
            $i++
        } else {
            $B[$k] = $A[$j]
            $j++
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

Invoke-MergeSort $values
Write-Host ($values -join ', ')
