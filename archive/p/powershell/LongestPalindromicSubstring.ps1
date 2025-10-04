function Show-Usage() {
    Write-Host "Usage: please provide a string that contains at least one palindrome"
    Exit 1
}

# Source: https://www.geeksforgeeks.org/longest-palindromic-substring-using-dynamic-programming/
function Invoke-LongestPalindromicSubstring($Str) {
    $lcStr = $Str.ToLower()

    # Initialize array indicating where match between two strings
    $n = $Str.Length
    $matches =  @(1..$n | ForEach-Object { , (@($false) * $n) })

    # Indicate all length 1 strings match
    for ($i = 0; $i -lt $n; $i++) {
        $matches[$i][$i] = $true
    }

    # Find all length 2 matches
    $start = 0
    $maxLen = 1
    for ($i = 0; $i -lt $n - 1; $i++) {
        if ($lcStr[$i] -eq $lcStr[$i + 1]) {
            $matches[$i][$i + 1] = $true
            if ($maxLen -lt 2) {
                $start = $i
                $maxLen = 2
            }
        }
    }

    # Find all length 3 or higher matches
    for ($len = 3; $len -le $n; $len++) {
        # Loop through each starting character
        for ($i = 0; $i -lt $n - $len + 1; $i++) {
            # If match for one character in from start and end characters
            # and start and end characters match, set match for start and
            # end characters, and update max length
            $j = $i + $len - 1
            if ($matches[$i + 1][$j - 1] -and $lcStr[$i] -eq $lcStr[$j]) {
                $matches[$i][$j] = $true
                if ($len -gt $maxLen) {
                    $start = $i
                    $maxLen = $len
                }
            }
        }
    }

    $Str.Substring($start, $maxLen)
}

if ($args.Length -lt 1 -or -not $args[0]) {
    Show-Usage
}

$result = Invoke-LongestPalindromicSubstring $args[0]
if ($result.Length -lt 2) {
    Show-Usage
}

Write-Output $result
