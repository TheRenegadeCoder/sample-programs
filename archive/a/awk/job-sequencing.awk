function usage() {
    print "Usage: please provide a list of profits and a list of deadlines"
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function str_to_array(s, arr,  str_arr, idx, result) {
    split(s, str_arr, ",")
    for (idx in str_arr) {
        result = str_to_number(str_arr[idx])
        if (result == "ERROR") {
            delete arr
            arr[1] = "ERROR"
            break
        } else {
            arr[idx] = result
        }
    }
}

# Source: https://www.techiedelight.com/job-sequencing-problem-deadlines/
function job_sequencing(profits, deadlines, jobs, slots,  i, j, longest_deadline, temp_jobs) {
    # Set up job details and longest deadline
    longest_deadline = 0
    for (i in profits) {
        temp_jobs[i]["id"] = i
        temp_jobs[i]["profit"] = profits[i]
        temp_jobs[i]["deadline"] = deadlines[i]
        if (deadlines[i] > longest_deadline) {
            longest_deadline = deadline[i]
        }
    }

    # Initialize job slots
    for (i = 1; i <= longest_deadline; i++) {
        slots[i] = 0
    }

    # Sort jobs by profit then deadline
    asort(temp_jobs, jobs, "compare_profits_and_deadlines")

    # For each job, see if there is available slot at or before the deadline
    # if so, store this job in that slot
    for (i in jobs) {
        for (j = jobs[i]["deadline"]; j >= 1; j--) {
            if (!slots[j]) {
                slots[j] = i
                break
            }
        }
    }
}

# Prioritize by profit, then deadline
# Inputs:
# - i1 = Index 1 (unused)
# - v1 = Job 1
# - i2 = Index 2 (unused)
# - v2 = Job 2
# Returns:
# - negative if job 1 has higher profit or later deadline than job 2
# - zero if job 1 has same profit and deadline as job 2
# - positive if job 1 lower profit or sooner deadline than job 2
function compare_profits_and_deadlines(i1, v1, i2, v2,  diff) {
    # Compare profits in reverse order since we want higher profits to be first
    # If equal, compare deadlines in reverse order since we want later deadlines
    # to be first
    diff = v2["profit"] - v1["profit"]
    return (diff != 0) ? diff : v2["deadline"] - v1["deadline"]
}

function get_total_profit(profits, jobs, slots,  total, idx) {
    total = 0
    for (idx in slots) {
        if (slots[idx]) {
            total += jobs[slots[idx]]["profit"]
        }
    }

    return total
}

BEGIN {
    if (ARGC < 3) {
        usage()
    }

    str_to_array(ARGV[1], profits)
    num_profits = length(profits)
    str_to_array(ARGV[2], deadlines)
    num_deadlines = length(deadlines)
    if (!num_profits || profits[1] == "ERROR" || \
        !num_deadlines || deadlines[1] == "ERROR" || \
        num_profits != num_deadlines) {
        usage()
    }

    job_sequencing(profits, deadlines, jobs, slots)
    total_profit = get_total_profit(profits, jobs, slots)
    print total_profit
}
