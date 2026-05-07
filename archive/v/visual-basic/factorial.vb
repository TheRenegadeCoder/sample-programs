Imports System.Numerics

Module Factorial

    Private Function Fact(n As BigInteger) As BigInteger
        If n <= 1 Then
            Return 1
        End If

        Return n * Fact(n - 1)
    End Function


    Public Sub Main(args As String())

        If args.Length = 0 Then
            ShowUsage()
            Return
        End If

        Dim n As BigInteger

        If Not BigInteger.TryParse(args(0), n) Then
            ShowUsage()
            Return
        End If

        If n < 0 Then
            ShowUsage()
            Return
        End If

        If n > 4550 Then
            Console.WriteLine($"{n}! is out of the reasonable bounds for calculation.")
            Environment.Exit(1)
        End If

        Dim result = Fact(n)
        Console.WriteLine(result)

    End Sub


    Private Sub ShowUsage()
        Console.WriteLine("Usage: please input a non-negative integer")
        Environment.Exit(1)
    End Sub

End Module