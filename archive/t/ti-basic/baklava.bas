For(N,0,20)
    abs(10-N)->S
    21-2*S->T
    ""->Str1
    For(I,1,S)
        Str1+" "->Str1
    End
    For(I,1,T)
        Str1+"*"->Str1
    End
    Disp Str1
End
