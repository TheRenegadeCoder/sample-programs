function Show-Usage() {
    Write-Host "Usage: please enter the dimension of the matrix and the serialized matrix"
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

function ConvertTo-Matrix([int]$numCols, [int]$numRows, [array]$values) {
    @(0..($numRows - 1) | ForEach-Object { , $values[($_ * $numCols)..($_ * $numCols + $numCols - 1)]})
}

function Invoke-TransposeMatrix($matrix) {
    @(0..($matrix[0].Length - 1) | ForEach-Object {
        $i = $_
        , (0..($matrix.Length - 1) | ForEach-Object { $matrix[$_][$i]})
    })
}

function ConvertFrom-Matrix([int[][]]$matrix) {
    @($matrix | ForEach-Object { $_ })
}

if ($args.Length -lt 3 -or -not $args[2]) {
    Show-Usage
}

try {
    $numCols = [int]::Parse($args[0])
    $numRows = [int]::Parse($args[1])
    $values = Parse-IntList($args[2])
    if ($numCols * $numRows -ne $values.Length) {
        Show-Usage
    }
} catch {
    Show-Usage
}

$matrix = ConvertTo-Matrix $numCols $numRows $values
$tMatrix = Invoke-TransposeMatrix $matrix
$tValues = ConvertFrom-Matrix $tMatrix
Write-Output ($tValues -join ', ')
