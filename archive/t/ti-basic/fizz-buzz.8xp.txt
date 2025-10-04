For(N,1,100)
    If remainder(N,15)=0 Then Disp("FizzBuzz")
    Else
        If remainder(N,3)=0 Then Disp("Fizz")
        Else
            If remainder(N,5)=0 Then Disp("Buzz")
            Else Disp(N)
            End
        End
    End
End
