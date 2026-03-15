begin
    procedure outRepeatString(n, s);
    value n;
    integer n;
    string s;
    begin
        integer i;
        for i := 1 step 1 until n do outstring(1, s)
    end outRepeatString;

    integer i, numspaces, numstars;
    for i := -10 step 1 until 10 do
    begin
        numspaces := abs(i);
        numstars := 21 - 2 * numspaces;
        outRepeatString(numspaces, " ");
        outRepeatString(numstars, "*");
        outstring(1, "\n")
    end
end
