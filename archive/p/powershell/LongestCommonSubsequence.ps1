function Show-Usage() {
    Write-Host 'Usage: please provide two lists in the format "1, 2, 3, 4, 5"'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

# Source: https://en.wikipedia.org/wiki/Longest_common_subsequence
# However, instead of storing lengths, and index to the subsequence is stored
function Invoke-LongestCommonSubsequence([array]$List1, [array]$List2) {
    # Initialize all subsequences to an empty sequence
    $m = $List1.Length
    $n = $List2.Length
    $c = @(0..$m | ForEach-Object { , (@(0) * ($n + 1)) })
    $subsequences = @(, @())

    # Find the longest common subsequence using prior subsequences
    for ($i = 1; $i -le $m; $i++) {
        for ($j = 1; $j -le $n; $j++) {
            # If common element found, create new subsequence based on prior
            # subsequence with the common element appended
            if ($List1[$i - 1] -eq $List2[$j - 1]) {
                $c[$i][$j] = $subsequences.Length
                $subsequences += , ($subsequences[$c[$i - 1][$j - 1]] + $List1[$i - 1])
            }
            # Else, reuse the longer of the two prior subsequences
            else {
                $index1 = $c[$i][$j - 1]
                $index2 = $c[$i - 1][$j]
                $c[$i][$j] = ($subsequences[$index1].Length -gt $subsequences[$index2].Length) ?
                    $index1 : $index2
            }
        }
    }

    $subsequences[$c[$m][$n]]
}

if ($args.Length -lt 2 -or -not $args[0] -or -not $args[1]) {
    Show-Usage
}

try {
    $list1 = Parse-IntList($args[0])
    $list2 = Parse-IntList($args[1])
} catch {
    Show-Usage
}

$result = Invoke-LongestCommonSubsequence $list1 $list2
Write-Output ($result -join ', ')
