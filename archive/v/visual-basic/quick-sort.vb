Public Module QuickSort

    Public Function Sort(Of T)(input As IEnumerable(Of T),
                               Optional compare As IComparer(Of T) = Nothing) As List(Of T)

        If compare Is Nothing Then
            compare = Comparer(Of T).Default
        End If

        Dim list As New List(Of T)(input)
        If list.Count < 2 Then Return list

        QuickSortInternal(list, 0, list.Count - 1, compare)
        Return list

    End Function


    Private Sub QuickSortInternal(Of T)(list As List(Of T),
                                       low As Integer,
                                       high As Integer,
                                       comparer As IComparer(Of T))

        If low >= high Then
            Return
        End If

        Dim pivotIndex As Integer = Partition(list, low, high, comparer)

        QuickSortInternal(list, low, pivotIndex - 1, comparer)
        QuickSortInternal(list, pivotIndex + 1, high, comparer)

    End Sub


    Private Function Partition(Of T)(list As List(Of T),
                                    low As Integer,
                                    high As Integer,
                                    comparer As IComparer(Of T)) As Integer

        Dim pivot = list(high)
        Dim i As Integer = low - 1

        For j As Integer = low To high - 1

            If comparer.Compare(list(j), pivot) <= 0 Then
                i += 1
                Swap(list, i, j)
            End If

        Next

        Swap(list, i + 1, high)

        Return i + 1

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