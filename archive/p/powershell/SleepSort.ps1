function Show-Usage() {
    Write-Host 'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

function Invoke-SleepSort([int[]]$Values) {
    @($Values | ForEach-Object -Parallel {
        Start-Sleep $_
        $_
    } -ThrottleLimit $Values.Length)
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

$sortedValues = Invoke-SleepSort $values
Write-Host ($sortedValues -join ', ')
