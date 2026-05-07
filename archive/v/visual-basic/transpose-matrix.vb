Public Module TransposeMatrix

    Private Sub ShowUsage()
        Console.Error.WriteLine("Usage: please enter the dimension of the matrix and the serialized matrix")
        Environment.Exit(1)
    End Sub


    Private Function ParseIntegerList(input As String) As List(Of Integer)

        If String.IsNullOrWhiteSpace(input) Then
            ShowUsage()
        End If

        Dim numbers As New List(Of Integer)

        For Each token In input.Split(","c, StringSplitOptions.RemoveEmptyEntries Or StringSplitOptions.TrimEntries)

            Dim value As Integer

            If Not Integer.TryParse(token, value) Then
                ShowUsage()
            End If

            numbers.Add(value)

        Next

        Return numbers

    End Function


    Private Function TransposeMatrix(cols As Integer, rows As Integer, input As List(Of Integer)) As List(Of Integer)

        Dim result As New List(Of Integer)(New Integer(rows * cols - 1) {})

        For i As Integer = 0 To rows - 1

            For j As Integer = 0 To cols - 1

                Dim sourceIndex As Integer = i * cols + j
                Dim targetIndex As Integer = j * rows + i

                result(targetIndex) = input(sourceIndex)

            Next

        Next

        Return result

    End Function


    Public Sub Main(args As String())

        If args.Length <> 3 Then
            ShowUsage()
        End If

        Dim cols As Integer
        Dim rows As Integer

        If Not Integer.TryParse(args(0), cols) OrElse Not Integer.TryParse(args(1), rows) Then
            ShowUsage()
        End If

        Dim numbers = ParseIntegerList(args(2))

        If numbers.Count <> cols * rows Then
            ShowUsage()
        End If

        Dim transposed = TransposeMatrix(cols, rows, numbers)

        Console.WriteLine(String.Join(", ", transposed))

    End Sub

End Module