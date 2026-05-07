Module EvenOdd

    Public Sub Main(args As String())

        If args.Length = 0 Then
            Console.WriteLine("Usage: please input a number")
            Environment.Exit(1)
        End If

        Dim n As Integer

        If Not Integer.TryParse(args(0), n) Then
            Console.WriteLine("Usage: please input a number")
            Environment.Exit(1)
        End If

        Dim result As String = If(n Mod 2 = 0, "Even", "Odd")

        Console.WriteLine(result)

    End Sub

End Module