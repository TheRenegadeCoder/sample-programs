function Show-Usage() {
    Write-Host "Usage: please provide a string to encrypt"
    Exit 1
}

function Get-Rot13([string]$Str) {
    # -regex is case-insensitve
    $Result = switch -regex ($Str.ToCharArray()) {
        "[a-m]" { [char]([byte]$_ + 13) } # A-M, a-m -> N-Z, n-z
        "[n-z]" { [char]([byte]$_ - 13) } # N-Z, n-z -> A-M, a-m
        default { $_ } # Else, don't change
    }
    -join $Result
}

if ($args.Length -lt 1 -or -not $args[0]) {
    Show-Usage
}

Write-Host (Get-Rot13($args[0]))
