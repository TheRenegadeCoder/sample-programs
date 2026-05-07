Public Module MergeSort

    Public Function Sort(Of T)(input As IEnumerable(Of T),
                               Optional compare As IComparer(Of T) = Nothing) As List(Of T)

        If compare Is Nothing Then
            compare = Comparer(Of T).Default
        End If

        Dim list As New List(Of T)(input)
        If list.Count < 2 Then Return list

        Return MergeSortInternal(list, compare)

    End Function


    Private Function MergeSortInternal(Of T)(list As List(Of T),
                                             comparer As IComparer(Of T)) As List(Of T)

        If list.Count <= 1 Then
            Return list
        End If

        Dim mid As Integer = list.Count \ 2

        Dim left = list.GetRange(0, mid)
        Dim right = list.GetRange(mid, list.Count - mid)

        Dim sortedLeft = MergeSortInternal(left, comparer)
        Dim sortedRight = MergeSortInternal(right, comparer)

        Return Merge(sortedLeft, sortedRight, comparer)

    End Function


    Private Function Merge(Of T)(left As List(Of T),
                                 right As List(Of T),
                                 comparer As IComparer(Of T)) As List(Of T)

        Dim result As New List(Of T)(left.Count + right.Count)

        Dim i As Integer = 0
        Dim j As Integer = 0

        While i < left.Count AndAlso j < right.Count

            If comparer.Compare(left(i), right(j)) <= 0 Then
                result.Add(left(i))
                i += 1
            Else
                result.Add(right(j))
                j += 1
            End If

        End While

        While i < left.Count
            result.Add(left(i))
            i += 1
        End While

        While j < right.Count
            result.Add(right(j))
            j += 1
        End While

        Return result

    End Function


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