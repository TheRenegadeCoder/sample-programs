function Show-Usage() {
    Write-Host 'Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

# Find maximum subarray using Kadane's algorithm.
# Source: https://en.wikipedia.org/wiki/Maximum_subarray_problem#No_empty_subarrays_admitted
function Invoke-MaximumSubarray([array]$Values) {
    $bestSum = [int]::MinValue
    $currentSum = 0
    foreach ($value in $Values) {
        $currentSum = $value + [int][Math]::Max(0, $currentSum)
        $bestSum = [int][Math]::Max($bestSum, $currentSum)
    }

    $bestSum
}

if ($args.Length -lt 1) {
    Show-Usage
}

try {
    $values = Parse-IntList $args[0]
} catch {
    Show-Usage
}

$maxValue = Invoke-MaximumSubarray $values
Write-Host $maxValue
