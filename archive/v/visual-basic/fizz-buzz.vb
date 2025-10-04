Option Explicit On
Module FizzBuzz
    Public Sub Main()
        FizzBuzz()
    End Sub
    Sub FizzBuzz()
        Dim i As Integer
        For i = 1 To 100
            If i Mod 15 = 0 Then
                System.Console.WriteLine("FizzBuzz")
            ElseIf i Mod 5 = 0 Then
                System.Console.WriteLine("Buzz")
            ElseIf i Mod 3 = 0 Then
                System.Console.WriteLine("Fizz")
            Else
                System.Console.WriteLine(i)
            End If
        Next
    End Sub
End Module
