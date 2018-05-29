<#
.SYNOPSIS
  A simple script for reversing a String.

.DESCRIPTION
  A simple script for reversing a String in PowerShell in order to show some
features of the language.

.PARAMETER Input
  The string to reverse.

.EXAMPLE
  .\Reverse-String.ps1 -Input 'Hello, World'

.EXAMPLE
  .\Reverse-String.ps1 "Les Misérables"

.EXAMPLE
  .\Reverse-String.ps1 "字樣樣品"

.NOTES
  This script does *not* support emoji as PowerShell only has full support for
emoji within the ISE.
#>
param
(
  [Parameter(Mandatory = $true,
             Position = 0)]
  [ValidateNotNullOrEmpty()]
  [string]$Input
)

$StringBuilder = New-Object -TypeName System.Text.StringBuilder($Input.Length)

for ($x = ($Input.Length - 1); $x -ge 0; $x--) {
  [void]$StringBuilder.Append($Input.Chars($x))
}

Write-Host $StringBuilder.ToString()
