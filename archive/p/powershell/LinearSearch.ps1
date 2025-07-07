function Show-Usage() {
    Write-Host 'Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

function Invoke-LinearSearch([int[]]$arr, [int]$target) {
    $arr.IndexOf($target)
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

$idx = Invoke-LinearSearch $arr $target
Write-Output (($idx -ge 0) ? "true" : "false")
