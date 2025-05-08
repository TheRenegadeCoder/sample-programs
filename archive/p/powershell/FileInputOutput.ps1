function Set-File([string]$Filename) {
    try {
        $StreamWriter = [IO.StreamWriter]::new($FileName)
        $StreamWriter.WriteLine("Hello, PowerShell!")
        $StreamWriter.WriteLine("A line here")
        $StreamWriter.WriteLine("A line there")
        $StreamWriter.WriteLine("Goodbye, PowerShell!")
        $true
    } catch {
        Write-Host "Cannot write to file ${Filename}: $($_.Exception.Message)"
        $false
    } finally {
        if ($StreamWriter) {
            $StreamWriter.Close()
            $StreamWriter.Dispose()
        }
    }
}

function Get-File([string]$Filename) {
    try {
        foreach ($Line in Get-Content -Path $Filename -ErrorAction Stop) {
            Write-Host $Line
        }
        $true
    } catch {
        Write-Host "Cannot read from file ${Filename}: $($_.Exception.Message)"
        $false
    }
}

$Filename = "output.txt"
if (-not (Set-File($Filename))) {
    Exit 1
}

if (-not (Get-File($Filename))) {
    Exit 1
}
