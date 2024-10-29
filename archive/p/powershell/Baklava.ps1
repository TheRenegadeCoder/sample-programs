for ($X = -10; $X -le 10; $X++) {
    $NumSpaces = [Math]::Abs($X)
    $Line = " " * $NumSpaces + "*" * (21 - 2 * $NumSpaces)
    Write-Output $Line
}
