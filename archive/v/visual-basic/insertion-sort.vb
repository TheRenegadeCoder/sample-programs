Public Module InsertionSort

    Public Function Sort(Of T)(input As IEnumerable(Of T),
                               Optional compare As IComparer(Of T) = Nothing) As List(Of T)

        If compare Is Nothing Then
            compare = Comparer(Of T).Default
        End If

        Dim result As New List(Of T)

        For Each item In input
            Insert(result, item, compare)
        Next

        Return result

    End Function


    Private Sub Insert(Of T)(list As List(Of T),
                             value As T,
                             comparer As IComparer(Of T))

        Dim low As Integer = 0
        Dim high As Integer = list.Count - 1

        While low <= high

            Dim mid As Integer = low + ((high - low) \ 2)

            If comparer.Compare(list(mid), value) < 0 Then
                low = mid + 1
            Else
                high = mid - 1
            End If

        End While

        list.Insert(low, value)

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