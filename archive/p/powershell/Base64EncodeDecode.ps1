function Show-Usage() {
    Write-Host "Usage: please provide a mode and a string to encode/decode"
    Exit 1
}

function Get-EncodeBase64([string]$Str) {
    $Bytes = [Text.Encoding]::Ascii.GetBytes($Str)
    [Convert]::ToBase64String($Bytes)
}

function Get-DecodeBase64([string]$Str) {
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
        $Result = Get-EncodeBase64($Str)
    }
    "decode" {
        try {
            $Result = Get-DecodeBase64($Str)
        } catch [Management.Automation.MethodInvocationException] {
            Show-Usage
        }
    }
    default {
        Show-Usage 
    }
}

Write-Host $Result
