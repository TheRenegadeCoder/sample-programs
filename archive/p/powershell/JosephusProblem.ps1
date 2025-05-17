function Show-Usage() {
    Write-Host "Usage: please input the total number of people and number of people to skip."
    Exit 1
}

<#
Reference: https://en.wikipedia.org/wiki/Josephus_problem#The_general_case

Use zero-based index algorithm:
//
    g(1, k) = 0
    g(m, k) = [g(m - 1, k) + k] MOD m, for m = 2, 3, ..., n

Final answer is g(n, k) + 1 to get back to one-based index
#>
function Get-JosephusProblem([int]$N, [int]$K) {
    $G = 0
    2..$N | ForEach-Object { $G = ($G + $K) % $_ }
    $G + 1
}

if ($args.Length -lt 2) {
    Show-Usage
}

try {
    $N = [int]::Parse($args[0])
    $K = [int]::Parse($args[1])
} catch {
    Show-Usage
}

Write-Host (Get-JosephusProblem $N $K)
