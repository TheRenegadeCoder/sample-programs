function Show-Usage() {
    Write-Host 'Usage: please provide a list of profits and a list of deadlines'
    Exit 1
}

function Parse-IntList([string]$Str) {
    @($Str.Split(",") | ForEach-Object { [int]::Parse($_) })
}

class Job {
    [int]$Id
    [int]$Profit
    [int]$Deadline

    Job([int]$id, [int]$profit, [int]$deadline) {
        $this.Id = $id
        $this.Profit = $profit
        $this.Deadline = $deadline
    }
}

# Source: https://www.techiedelight.com/job-sequencing-problem-deadlines/
function Invoke-JobSequencing([array]$Profits, [array]$Deadlines) {
    # Set up job details and longest deadline
    $longestDeadline = ($Deadlines | Measure-Object -Maximum).Maximum
    $jobs = @()
    for ($i = 0; $i -lt $Profits.Length; $i++) {
        $jobs += [Job]::new($i, $Profits[$i], $Deadlines[$i])
    }

    # Initialize job slots
    $slots = @($null) * ($longestDeadline + 1)

    # Sort jobs by profit then deadline
    $jobs = $jobs | Sort-Object -Descending -Property Profit, Deadline

    # For each job, see if there is available slot at or before the deadline
    # if so, store this job in that slot
    foreach ($job in $jobs) {
        for ($j = $job.Deadline; $j -ge 1; $j--) {
            if (-not $slots[$j]) {
                $slots[$j] = $job
                break
            }
        }
    }

    $slots
}

function Get-TotalProfit([Job[]]$jobs) {
    ($jobs.Profit | Measure-Object -Sum).Sum
}

if ($args.Length -lt 2 -or -not $args[0] -or -not $args[1]) {
    Show-Usage
}

try {
    $profits = Parse-IntList $args[0]
    $deadlines = Parse-IntList $args[1]
    if ($profits.Length -ne $deadlines.Length) {
        Show-Usage
    }
} catch {
    Show-Usage
}

$jobs = Invoke-JobSequencing $profits $deadlines
Write-Output (Get-TotalProfit $jobs)
