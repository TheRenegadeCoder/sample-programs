"0123456789"->Str2
2->dim(l1)
1->M
0->E
While E=0 and M<=2
    Input "",Str1
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
    E or D<1->E
    V->l1(M)
    M+1->M
End
If E Then Disp "Usage: please input the total number of people and number of people to skip."
Else
    :"Source: https://en.wikipedia.org/wiki/Josephus_problem#The_general_case"
    0->G
    l1(1)->N
    l1(2)->K
    For(M,2,N)
        remainder(G+K,M)->G
    End
    Disp G+1
End
