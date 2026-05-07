Public Module RemoveAllWhitespace

    Private Sub ShowUsage()
        Console.WriteLine("Usage: please provide a string")
        Environment.Exit(1)
    End Sub


    Private Sub RemoveAllWhitespace(input As String)

        Dim result As New System.Text.StringBuilder()

        For Each ch As Char In input

            If Not Char.IsWhiteSpace(ch) Then
                result.Append(ch)
            End If

        Next

        Console.WriteLine(result.ToString())

    End Sub


    Public Function Main(args As String()) As Integer

        If args Is Nothing OrElse args.Length = 0 OrElse String.IsNullOrEmpty(args(0)) Then
            ShowUsage()
        End If

        RemoveAllWhitespace(args(0))

        Return 0

    End Function

End Module