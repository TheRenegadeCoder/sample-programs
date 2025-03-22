Input "",Str1
"0123456789"->Str2
length(Str1)->L
L<1->E
0->D
0->V
1->N
1->S
While E=0 and N<=L
    sub(Str1,N,1)->C
    inString(Str2,C)-1->K
    If C="+" or C="-"
    Then
        D>0->E
        If C="-"
        Then 0-S->S
        End
    Else
        K<0->E
        D+1->D
        V*10+K*S->V
    End
    N+1->N
End
If E or D<1 or V<0 Then Disp "Usage: please input a non-negative integer"
Else
    V=2 or (V>=3 and remainder(V,2)~=0)->P
    3->N
    sqrt(V)->Q
    While P and N<=Q
        remainder(V,N)~=0->P
        N+2->N
    End
    If P Then Disp "prime"
    Else Disp "composite"
    End
End
