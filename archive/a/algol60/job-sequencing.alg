begin
    procedure usage;
    begin
        outstring(
            1,
            "Usage: please provide a list of profits and a list of deadlines\n"
        );
        stop
    end usage;

    comment Input a digit character from stdin and return the following:
        - "0" to "9" maps to 0 to 9
        - "+" maps to 10
        - "-" maps to 11
        - whitespace maps to 12
        - comma maps to 13
        - null byte maps to -1
        - invalid bytes map to -2;
    integer procedure indigit;
    begin
        comment Mapping:
            - "0" to "9" maps to 1 to 10
            - "+" maps to 11
            - "-" maps to 12
            - "\t" maps to 13
            - "\r" maps to 14
            - "\n" maps to 15
            - " " maps to 16
            - "," maps to 17
            - null byte maps to 18
            - invalid byte maps 0;
        integer ch;
        inchar(0, "0123456789+-\t\r\n ,", ch);
        if ch < 1 then ch := -2
        else if ch < 13 then ch := ch - 1
        else if ch < 17 then ch := 12
        else if ch = 17 then ch := 13
        else ch := -1;
        indigit := ch
    end indigit;

    comment Input an integer from stdin into 'result' and parse it.
        The last character is read into 'ch'.
        return true if integer is valid, false otherwise;
    boolean procedure inValidInteger(result, ch, allowComma);
    value allowComma;
    integer result, ch;
    boolean allowComma;
    begin
        boolean valid, commaFound;
        integer s;

        result := 0;
        valid := false;
        commaFound := false;
        s := 1;

        comment Ignore whitespace;
    whiteloop:
        ch := indigit;
        if ch = 12 then goto whiteloop;

        comment Process signs: ignore "+" and invert sign if "-";
    signloop:
        if ch = 10 | ch = 11 then
        begin
            if ch = 11 then s := -s;
            ch := indigit;
            goto signloop
        end;

        comment Indicate valid if "0" to "9";
        if ch >= 0 & ch <= 9 then valid := true;

        comment Process digits: update value;
    valueloop:
        if ch >= 0 & ch <= 9 then
        begin
            comment Invalid if overflow or underflow;
            if (s > 0 & (maxint - ch) % 10 < result) |
                (s < 0 & (-1 - maxint + ch) % 10 > result) then valid := false;
            
            result := result * 10 + s * ch;
            ch := indigit;
            goto valueloop
        end;

        comment If comma not allowed, ignore characters until end
            input. If comma allowed, ignore characters until comma
            or end of input. Indicate if comma found;
    ignoreloop:
        if !(ch = -1 | (allowComma & ch = 13)) then
        begin
            if ch != 12 & ch != 13 then valid := false;
            if ch = 13 then
            begin
                commaFound := true;
                if !allowComma then valid := false
            end;

            ch := indigit;
            goto ignoreloop
        end;

        comment If comma found, indicate last character is comma;
        if commaFound then ch := 13;

        inValidInteger := valid
    end inValidInteger;

    comment Returns length of array if valid, -1 otherwise;
    integer procedure inIntegerArray(arr, maxLen);
    value maxLen;
    integer array arr;
    integer maxLen;
    begin
        integer arrLen, val, ch;
        boolean valid;

        arrLen := 0;

        comment Get value with possible comma (13). Indicate invalid,
            if invalid integer. Otherwise, append value to array if
            no invalid values and there is room;
    itemloop:
        if !inValidInteger(val, ch, true) then arrLen := -1
        else if arrLen >= 0 & arrLen < maxLen then
        begin
            arrLen := arrLen + 1;
            arr[arrLen] := val
        end;

        comment Repeat until end of input;
        if ch != -1 then goto itemloop;

        inIntegerArray := arrLen
    end inIntegerArray;

    comment Job sequencing with deadlines. Source
        https://www.techiedelight.com/job-sequencing-problem-deadlines/;
    integer procedure jobSequencing(profits, deadlines, n);
    value n;
    integer array profits, deadlines;
    integer n;
    begin
        integer i, j, d, maxDeadline, totalProfit;
        integer array jobs[1:n, 1:2];

        comment Set up jobs and get maximum deadline;
        maxDeadline := 0;
        for i := 1 step 1 until n do
        begin
            d := deadlines[i];
            jobs[i, 1] := profits[i];
            jobs[i, 2] := d;
            if d > maxDeadline then maxDeadline := d
        end;

        comment Initialize total profit;
        totalProfit := 0;

        begin
            comment Initialize slots;
            integer array slots[1:maxDeadline];

            for i := 1 step 1 until maxDeadline do slots[i] := 0;

            comment Sort jobs by profit then deadline;
            bubbleSort(jobs, n);

            for i := 1 step 1 until n do
            begin
                comment For each job, see if there is available slot at or
                    before the deadline. If so, store this job index in that
                    slot and update total profit;
                j := jobs[i, 2] + 1;
            searchloop:
                j := j - 1;
                if j >= 1 then
                begin
                    if slots[j] > 0 then goto searchloop;
                    slots[j] := i;
                    totalProfit := totalProfit + jobs[i, 1]
                end
            end;
        end;

        
        jobSequencing := totalProfit
    end jobSequencing;

    comment Source https://en.wikipedia.org/wiki/Bubble_sort#Optimizing_bubble_sort;
    procedure bubbleSort(jobs, numJobs);
    value numJobs;
    integer array jobs;
    integer numJobs;
    begin
        integer i, n, newN;

        n := numJobs;
    sortloop:
        newN := 1;
        for i := 2 step 1 until n do
        begin
            if compareJobs(jobs, i - 1, i) > 0 then
            begin
                swapJobs(jobs, i - 1, i);
                newN := i
            end
        end;

        n := newN;
        if n > 2 then goto sortloop
    end bubbleSort;

    comment Prioritize job with highest profit then longest deadline.
        For jobs, profits are in column 1, deadlines as in column 2.
        Returns:
        - negative if first job has higher priority
        - zero if both jobs have same priority
        - positive if second job has higher priority;
    integer procedure compareJobs(jobs, i, j);
    value i, j;
    integer array jobs;
    integer i, j;
    begin
        compareJobs := if jobs[i, 1] != jobs[j, 1] then jobs[j, 1] - jobs[i, 1]
            else jobs[j, 2] - jobs[i, 2]
    end compareJobs;

    procedure swapJobs(jobs, i, j);
    value i, j;
    integer array jobs;
    integer i, j;
    begin
        procedure swap(a, b);
        integer a, b;
        begin
            integer t;

            t := a;
            a := b;
            b := t
        end swap;

        swap(jobs[i, 1], jobs[j, 1]);
        swap(jobs[i, 2], jobs[j, 2])
    end swapJobs;

    integer argc, numProfits, numDeadlines, result;
    integer array profits[1:100], deadlines[1:100];
    
    comment Get number of parameters. Exit if too few;
    ininteger(0, argc);
    if argc < 2 then usage;

    comment Get profits from 1st argument. Exit if invalid;
    numProfits := inIntegerArray(profits, 100);
    if numProfits < 1 then usage;

    comment Get deadlines from 2nd argument. Exit if invalid or the number
        of deadlines is not the same as the number of profits;
    numDeadlines := inIntegerArray(deadlines, 100);
    if numDeadlines != numProfits then usage;

    comment Find best sum of profits and display result;
    result := jobSequencing(profits, deadlines, numProfits);
    outinteger(1, result);
    outstring(1, "\n")
end
