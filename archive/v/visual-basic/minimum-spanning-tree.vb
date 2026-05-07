Public Module MinimumSpanningTree

    Private Sub ShowUsage()
        Console.Error.WriteLine(
            "Usage: please provide a comma-separated list of integers"
        )
        Environment.Exit(1)
    End Sub


    Private Function ParseMatrix(input As String) As List(Of Integer)

        If String.IsNullOrWhiteSpace(input) Then
            ShowUsage()
        End If

        Dim result As New List(Of Integer)

        For Each token In input.Split(","c, StringSplitOptions.RemoveEmptyEntries Or StringSplitOptions.TrimEntries)

            Dim value As Integer
            If Not Integer.TryParse(token, value) Then
                ShowUsage()
            End If

            result.Add(value)

        Next

        If result.Count < 4 Then
            ShowUsage()
        End If

        Dim dimension As Integer = CInt(Math.Sqrt(result.Count))

        If dimension * dimension <> result.Count Then
            ShowUsage()
        End If

        Return result

    End Function


    Private Function MinimumSpanningTreeWeight(matrix As List(Of Integer), dimension As Integer) As Integer

        Dim inMST(dimension - 1) As Boolean
        Dim minEdge(dimension - 1) As Integer

        For i As Integer = 0 To dimension - 1
            minEdge(i) = Integer.MaxValue
        Next

        minEdge(0) = 0
        Dim totalWeight As Integer = 0

        For i As Integer = 0 To dimension - 1

            Dim minValue As Integer = Integer.MaxValue
            Dim node As Integer = -1

            For j As Integer = 0 To dimension - 1
                If Not inMST(j) AndAlso minEdge(j) < minValue Then
                    minValue = minEdge(j)
                    node = j
                End If
            Next

            If node = -1 Then
                ShowUsage()
            End If

            inMST(node) = True
            totalWeight += minValue

            For adj As Integer = 0 To dimension - 1

                Dim weight As Integer = matrix(node * dimension + adj)

                If weight <> 0 AndAlso Not inMST(adj) AndAlso weight < minEdge(adj) Then
                    minEdge(adj) = weight
                End If

            Next

        Next

        Return totalWeight

    End Function


    Public Function Main(args As String()) As Integer

        If args.Length <> 1 Then
            ShowUsage()
        End If

        Dim matrix = ParseMatrix(args(0))
        Dim dimension As Integer = CInt(Math.Sqrt(matrix.Count))

        Dim result = MinimumSpanningTreeWeight(matrix, dimension)

        Console.WriteLine(result)

        Return 0

    End Function

End Module