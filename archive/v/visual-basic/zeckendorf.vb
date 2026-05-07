Public Module Zeckendorf

    Private ReadOnly Fibs As Long() = GenerateFibs()


    Private Function GenerateFibs() As Long()

        Dim fs As New List(Of Long) From {1L, 2L}

        While Long.MaxValue - fs(fs.Count - 1) >= fs(fs.Count - 2)
            fs.Add(fs(fs.Count - 1) + fs(fs.Count - 2))
        End While

        Return fs.ToArray()

    End Function


    Public Sub Main(args As String())

        Dim n As Long

        If args.Length = 0 OrElse Not Long.TryParse(args(0), n) OrElse n < 0 Then

            Console.WriteLine("Usage: please input a non-negative integer")
            Return

        End If

        If n = 0 Then Return

        Dim terms As New List(Of Long)

        Dim count As Integer = Decompose(n, terms)

        Console.WriteLine(String.Join(", ", terms.GetRange(0, count)))

    End Sub


    Private Function Decompose(n As Long, terms As List(Of Long)) As Integer

        Dim count As Integer = 0

        Dim i As Integer = Array.BinarySearch(Fibs, n)

        If i < 0 Then
            i = Not i - 1
        End If

        For idx As Integer = i To 0 Step -1

            If n <= 0 Then Exit For

            If Fibs(idx) <= n Then
                terms.Add(Fibs(idx))
                n -= Fibs(idx)
                count += 1
            End If

        Next

        Return count

    End Function

End Module