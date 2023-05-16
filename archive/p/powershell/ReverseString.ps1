<#
.SYNOPSIS
  A simple script for reversing a String.

.DESCRIPTION
  A simple script for reversing a String in PowerShell in order to show some
features of the language.

.PARAMETER Str
  The string to reverse.

.EXAMPLE
  .\ReverseString.ps1 -Str 'Hello, World'

.EXAMPLE
  .\ReverseString.ps1 "Les Misérables"

.EXAMPLE
  .\ReverseString.ps1 "字樣樣品"

.NOTES
  This script does *not* support emoji as PowerShell only has full support for
emoji within the ISE.
#>
param
(
  [Parameter(Mandatory = $false, Position = 0)]
  [string]$Str
)

$StringBuilder = New-Object -TypeName System.Text.StringBuilder($Str.Length)

for ($x = ($Str.Length - 1); $x -ge 0; $x--) {
  [void]$StringBuilder.Append($Str.Chars($x))
}

Write-Host $StringBuilder.ToString()
