Public Module SelectionSort


    Public Function Sort(Of T)(input As IEnumerable(Of T),
                               Optional compare As IComparer(Of T) = Nothing) As List(Of T)

        If compare Is Nothing Then
            compare = Comparer(Of T).Default
        End If

        Dim list As New List(Of T)(input)

        If list.Count < 2 Then
            Return list
        End If

        SelectionSortInternal(list, compare)

        Return list

    End Function


    Private Sub SelectionSortInternal(Of T)(list As List(Of T), comparer As IComparer(Of T))

        For i As Integer = 0 To list.Count - 2

            Dim minIndex As Integer = FindMinIndex(list, i, comparer)

            If minIndex <> i Then
                Swap(list, i, minIndex)
            End If

        Next

    End Sub


    Private Function FindMinIndex(Of T)(list As List(Of T),
                                        startIndex As Integer,
                                        comparer As IComparer(Of T)) As Integer

        Dim minIndex As Integer = startIndex

        For j As Integer = startIndex + 1 To list.Count - 1

            If comparer.Compare(list(j), list(minIndex)) < 0 Then
                minIndex = j
            End If

        Next

        Return minIndex

    End Function

    Private Sub Swap(Of T)(list As List(Of T), i As Integer, j As Integer)
        Dim temp = list(i)
        list(i) = list(j)
        list(j) = temp
    End Sub


    Private Sub ShowUsage()

        Console.WriteLine(
            "Usage: please provide a list of at least two integers to sort " &
            "in the format ""1, 2, 3, 4, 5"""
        )

        Environment.Exit(1)

    End Sub


    Public Sub Main(args As String())

        If args.Length <> 1 Then
            ShowUsage()
        End If

        Dim parts = args(0).Split(","c, StringSplitOptions.RemoveEmptyEntries)

        Dim numbers As New List(Of Integer)

        For Each p In parts

            Dim value As Integer

            If Not Integer.TryParse(p.Trim(), value) Then
                ShowUsage()
            End If

            numbers.Add(value)

        Next

        If numbers.Count < 2 Then
            ShowUsage()
        End If

        Dim sorted = Sort(numbers)

        Console.WriteLine(String.Join(", ", sorted))

    End Sub

End Module