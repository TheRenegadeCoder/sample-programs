function Show-Usage() {
    Write-Host "Usage: please provide a mode and a string to encode/decode"
    Exit 1
}

function Get-Base64Encode([string]$Str) {
    $Bytes = [Text.Encoding]::Ascii.GetBytes($Str)
    [Convert]::ToBase64String($Bytes)
}

function Get-Base64Decode([string]$Str) {
    $Bytes = [Convert]::FromBase64String($Str)
    [Text.Encoding]::Ascii.GetString($Bytes)
}

if ($args.Length -lt 2 -or -not $args[1]) {
    Show-Usage
}

$Mode = $args[0]
$Str = $args[1]
switch ($Mode) {
    "encode" {
        $Result = Get-Base64Encode($Str)
    }
    "decode" {
        try {
            $Result = Get-Base64Decode($Str)
        } catch [Management.Automation.MethodInvocationException] {
            Show-Usage
        }
    }
    default {
        Show-Usage 
    }
}

Write-Host $Result
