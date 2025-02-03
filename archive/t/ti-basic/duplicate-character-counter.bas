Input "",Str1
length(Str1)->L
If L<1 Then Disp "Usage: please provide a string"
Else
    {}->l1
    ""->Str2
    0->M
    For(N,1,L)
        sub(Str1,N,1)->C
        inString(Str2,C)->K
        If K<1
        Then
            Str2+C->Str2
            M+1->M
            M->dim(l1)
            1->l1(M)
        Else
            l1(K)+1->l1(K)
        End
    End
    0->D
    For(N,1,M)
        If l1(N)>1
        Then
            Disp sub(Str2,N,1)+": "+toString(l1(N))
            1->D
        End
    End
    If D=0
    Then Disp "No duplicate characters"
    End
End
