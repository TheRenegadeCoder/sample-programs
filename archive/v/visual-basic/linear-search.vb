Module LinearSearch

    Public Sub Main(args As String())

        If args.Length < 2 Then
            ShowUsage()
            Return
        End If

        Dim list = ParseList(args(0))
        Dim target As Integer

        If list Is Nothing OrElse
           Not Integer.TryParse(args(1), target) Then

            ShowUsage()
            Return
        End If

        Console.WriteLine(Search(list, target))

    End Sub


    Private Function Search(list As List(Of Integer), target As Integer) As Boolean

        For Each value In list
            If value = target Then
                Return True
            End If
        Next

        Return False

    End Function


    Private Function ParseList(input As String) As List(Of Integer)

        If String.IsNullOrWhiteSpace(input) Then
            Return Nothing
        End If

        Dim result As New List(Of Integer)

        For Each part In input.Split(","c, StringSplitOptions.RemoveEmptyEntries)

            Dim value As Integer

            If Not Integer.TryParse(part.Trim(), value) Then
                Return Nothing
            End If

            result.Add(value)

        Next

        Return result

    End Function


    Private Sub ShowUsage()
        Console.WriteLine("Usage: please provide a list of integers (""1, 4, 5, 11, 12"") and the integer to find (""11"")")
        Environment.Exit(1)
    End Sub

End Module