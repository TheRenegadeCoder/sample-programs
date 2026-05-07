Imports System.Numerics

Module Fibonacci

    Public Sub Main(args As String())

        If args.Length = 0 Then
            ShowUsage()
            Return
        End If

        Dim n As Integer

        If Not Integer.TryParse(args(0), n) OrElse n < 0 Then
            ShowUsage()
            Return
        End If

        Dim first As BigInteger = 0
        Dim second As BigInteger = 1

        For i As Integer = 1 To n

            Dim current As BigInteger = first + second
            first = second
            second = current

            Console.WriteLine($"{i}: {first}")

        Next

    End Sub


    Private Sub ShowUsage()
        Console.WriteLine("Usage: please input the count of fibonacci numbers to output")
        Environment.Exit(1)
    End Sub

End Module