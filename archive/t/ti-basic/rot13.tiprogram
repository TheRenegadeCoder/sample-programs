Input "",Str1
"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"->Str2
"nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM"->Str3
length(Str1)->L
"Usage: please provide a string to encrypt"->Str4
If L>0 Then
    ""->Str4
    For(N,1,L)
        sub(Str1,N,1)->Str5
        inString(Str2,Str5)->K
        If K>0 Then Str4+sub(Str3,K,1)->Str4
        Else Str4+Str5->Str4
        End
    End
End
Disp Str4
