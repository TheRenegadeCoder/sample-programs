

Function Test-IsPrime {

<#
.Synopsis
Test if a number is prime
.Description
This command will test if a given number is prime based.
.Example
PS C:\> Test-IsPrime 123
Number IsPrime
------ -------
   123   False
.Example
PS C:\> 1..10 | Test-IsPrime | Where IsPrime
Number IsPrime
------ -------
     2    True
     3    True
     5    True
     7    True
     
.Example
PS C:\> Test-IsPrime 98765 -quiet
False

#>
[cmdletbinding()]
    
Param(
[Parameter(
Position = 0,
Mandatory,
HelpMessage = "Enter a number",
ValueFromPipeline
)]
[int]$Number,
[switch]$Quiet
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
} #begin

Process {
    Write-Verbose "[PROCESS] Testing $Number"
    if ($Number -eq 1) {
        
        $out = [pscustomobject]@{Number = $Number ; IsPrime = $False}
    }
    Else {
        #set the default
        $Prime = $True
        for ($i = 2;$i -le ([math]::Sqrt($Number));$i++) {
            $z = $Number/$i
            if ($z -is [int]) {
                $Prime = $False
                Break
            }
            
        } #for
        $out = [pscustomobject]@{Number = $Number ; IsPrime = $Prime}
    } #else
   if ($Quiet) {
        #write just the IsPrime Boolean property
        $out.IsPrime
    }
    else {
        #write the complete object
        $Out
    }
} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

} #test-isprime