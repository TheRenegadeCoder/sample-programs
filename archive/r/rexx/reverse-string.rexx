/* Reverse-String */

parse arg inputString
if inputString = "" then exit  /* exits right away if there is no input! */

say reverseString(inputString)
exit

reverseString:
parse arg str
length = length(str)
reversed = ""

do i = length to 1 by -1
reversed = reversed || substr(str, i, 1)
end

return reversed 
/* Req: Hello, World   Expected Res: dlroW ,olleH */
