Public Module Program

    Private Const INF As Integer = &H3F3F3F3F

    Private Sub ShowUsage()
        Console.Error.WriteLine(
            "Usage: please provide three inputs: " &
            "a serialized matrix, a source node and a destination node"
        )
        Environment.Exit(1)
    End Sub


    Private Function ParseIntegerList(input As String) As List(Of Integer)

        If String.IsNullOrWhiteSpace(input) Then
            ShowUsage()
        End If

        Return input.Split(","c, StringSplitOptions.RemoveEmptyEntries Or StringSplitOptions.TrimEntries) _
            .Select(Function(s)
                        Dim v As Integer
                        If Not Integer.TryParse(s, v) OrElse v < 0 Then
                            ShowUsage()
                        End If
                        Return v
                    End Function) _
            .ToList()

    End Function


    Private Function GetDimension(matrix As List(Of Integer)) As Integer
        Dim n = CInt(Math.Sqrt(matrix.Count))
        If n * n <> matrix.Count Then Return -1
        Return n
    End Function


    Private Function Dijkstra(matrix As List(Of Integer),
                               n As Integer,
                               source As Integer,
                               destination As Integer) As Integer

        Dim dist(n - 1) As Integer
        Dim visited(n - 1) As Boolean

        For i = 0 To n - 1
            dist(i) = INF
        Next

        dist(source) = 0

        Dim pq As New PriorityQueue(Of Integer, Integer)
        pq.Enqueue(source, 0)

        While pq.Count > 0

            Dim node = pq.Dequeue()

            If visited(node) Then Continue While
            visited(node) = True

            If node = destination Then
                Return dist(node)
            End If

            Dim baseIndex = node * n

            For i = 0 To n - 1

                Dim weight = matrix(baseIndex + i)

                If weight <= 0 Then Continue For
                If visited(i) Then Continue For

                Dim newDist = dist(node) + weight

                If newDist < dist(i) Then
                    dist(i) = newDist
                    pq.Enqueue(i, newDist)
                End If

            Next

        End While

        Return If(dist(destination) = INF, -1, dist(destination))

    End Function


    Public Function Main(args As String()) As Integer

        If args.Length <> 3 Then ShowUsage()

        Dim matrix = ParseIntegerList(args(0))
        Dim n = GetDimension(matrix)

        Dim source As Integer
        Dim dest As Integer

        If n = -1 OrElse
           Not Integer.TryParse(args(1), source) OrElse
           Not Integer.TryParse(args(2), dest) OrElse
           source < 0 OrElse source >= n OrElse
           dest < 0 OrElse dest >= n Then
            ShowUsage()
        End If

        Dim result = Dijkstra(matrix, n, source, dest)

        If result = -1 Then ShowUsage()

        Console.WriteLine(result)
        Return 0

    End Function

End Module