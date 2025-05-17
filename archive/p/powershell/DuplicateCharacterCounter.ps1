function Show-Usage() {
    Write-Host "Usage: please provide a string"
    Exit 1
}

function Get-Duplicate-Character-Counter([string]$Str) {
    $Counts = @{}
    $Str.ToCharArray() | ForEach-Object { $Counts[$_] += 1 }
    $Counts
}

function Show-Duplicate-Character-Counter([string]$Str, [object]$Counts) {
    $Dupes = $false
    $Str.ToCharArray() | Select-Object -Unique | ForEach-Object {
        if ($Counts[$_] -gt 1) {
            Write-Host "${_}: $($Counts[$_])"
            $Dupes = $true
        }
    }

    if (-not $Dupes) {
        Write-Host "No duplicate characters"
    }
}

if ($args.Length -lt 1 -or -not $args[0]) {
    Show-Usage
}

$Str = $args[0]
$Counts = Get-Duplicate-Character-Counter $Str
Show-Duplicate-Character-Counter $Str $Counts
