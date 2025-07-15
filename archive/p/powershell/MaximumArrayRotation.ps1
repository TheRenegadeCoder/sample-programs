function Show-Usage() {
    Write-Host 'Usage: please provide a list of integers (e.g. "8, 3, 1, 2")'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

function Invoke-MaximumArrayRotation([array]$Values) {
    # Calculate sum and initial array rotation
    $s = ($Values | Measure-Object -Sum).Sum
    $w = 0
    for ($i = 0; $i -lt $Values.Length; $i++) {
        $w += $i * $Values[$i]
    }

    # Initialize maximum array rotation
    $wMax = $w

    # Adjust array rotation and update maximum
    $n = $Values.Length
    for ($i = 0; $i -lt ($n - 1); $i++) {
        $w += $n * $Values[$i] - $s
        $wMax = [int][Math]::Max($wMax, $w)
    }

    $wMax
}

if ($args.Length -lt 1) {
    Show-Usage
}

try {
    $values = Parse-IntList $args[0]
} catch {
    Show-Usage
}

$maxValue = Invoke-MaximumArrayRotation $values
Write-Host $maxValue
