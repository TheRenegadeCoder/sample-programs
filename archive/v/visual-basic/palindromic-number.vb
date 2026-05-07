Public Module PalindromeNumber

    Private Sub ShowUsage()
        Console.WriteLine("Usage: please input a non-negative integer")
        Environment.Exit(1)
    End Sub


    Private Function IsPalindromeNumber(value As Long) As Boolean

        If value < 0 Then Return False

        Dim original As Long = value
        Dim reversed As Long = 0

        While value > 0
            Dim digit As Long = value Mod 10
            reversed = reversed * 10 + digit
            value \= 10
        End While

        Return original = reversed

    End Function


    Public Function Main(args As String()) As Integer

        If args.Length <> 1 Then
            ShowUsage()
        End If

        Dim value As Long

        If Not Long.TryParse(args(0), value) OrElse value < 0 Then
            ShowUsage()
        End If

        Console.WriteLine(IsPalindromeNumber(value).ToString().ToLower())

        Return 0

    End Function

End Module