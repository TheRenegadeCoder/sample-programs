Input "",Str1
"abcdefghijklmnopqrstuvwxyz"->Str2
"ABCDEFGHIJKLMNOPQRSTUVWXYZ"->Str3
If length(Str1)=0 Then Disp "Usage: please provide a string"
Else
    inString(Str2,sub(Str1,1,1))->N
    If N>0 Then Disp sub(Str3,N,1)+sub(Str1,2,length(Str1)-1)
    Else Disp Str1
    End
End
