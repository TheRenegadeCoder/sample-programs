function Usage() {
    Write-Host "Usage: please provide a mode and a string to encode/decode"
    Exit 1
}

function Encode-Base64([string]$Str) {
    $Bytes = [Text.Encoding]::Ascii.GetBytes($Str)
    [Convert]::ToBase64String($Bytes)
}

function Decode-Base64([string]$Str) {
    $Bytes = [Convert]::FromBase64String($Str)
    [Text.Encoding]::Ascii.GetString($Bytes)
}

if ($args.Length -lt 2 -or -not $args[1]) {
    Usage
}

$Mode = $args[0]
$Str = $args[1]
switch ($Mode) {
    "encode" { $Result = Encode-Base64($Str) }
    "decode" {
        try {
            $Result = Decode-Base64($Str)
        } catch [Management.Automation.MethodInvocationException] {
            Usage
        }
    }
    default { Usage }
}

Write-Host $Result
