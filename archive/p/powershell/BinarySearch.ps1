function Show-Usage() {
    Write-Host 'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

function Test-IsSorted([int[]]$arr) {
    for ($i = 1; $i -lt $arr.Length; $i++) {
        if ($arr[$i - 1] -gt $arr[$i]) {
            return $false
        }
    }

    $true
}

function Invoke-BinarySearch([int[]]$arr, [int]$target) {
    return [Array]::BinarySearch($arr, $target)
}

if ($args.Length -lt 2 -or -not $args[0]) {
    Show-Usage
}

try {
    $arr = Parse-IntList $args[0]
    $target = [int]::Parse($args[1])
} catch {
    Show-Usage
}

if (-not (Test-IsSorted $arr)) {
    Show-Usage
}

$idx = Invoke-BinarySearch $arr $target
Write-Output (($idx -ge 0) ? "true" : "false")
