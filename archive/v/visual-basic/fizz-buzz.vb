Option Explicit On
Module FizzBuzz
    Public Sub Main()
        FizzBuzz()
    End Sub
    Sub FizzBuzz()
        Dim first = True
        Dim i As Integer
        For i = 1 To 100
            If i Mod 15 = 0 Then
                If first Then
                    System.Console.Write("FizzBuzz")
                    first = False
                Else
                    System.Console.Write(", FizzBuzz")
                End If

            ElseIf i Mod 5 = 0 Then
                If first Then
                    System.Console.Write("Buzz")
                    first = False
                Else
                    System.Console.Write(", Buzz")
                End If
            ElseIf i Mod 3 = 0 Then
                If first Then
                    System.Console.Write("Fizz")
                    first = False
                Else
                    System.Console.Write(", Fizz")
                End If
            Else
                If first Then
                    System.Console.Write(Str(i))
                    first = False
                Else
                    System.Console.Write($", {Str(i)}")
                End If
            End If
        Next
    End Sub
End Module
