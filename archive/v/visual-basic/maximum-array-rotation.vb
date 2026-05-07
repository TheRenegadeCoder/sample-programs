Public Module MaximumArrayRotation

    Private Sub ShowUsage()
        Console.Error.WriteLine(
            "Usage: please provide a list of integers (e.g. ""8, 3, 1, 2"")"
        )
        Environment.Exit(1)
    End Sub


    Private Function ParseList(input As String) As List(Of Integer)

        If String.IsNullOrWhiteSpace(input) Then
            ShowUsage()
        End If

        Dim result As New List(Of Integer)

        For Each part In input.Split(","c, StringSplitOptions.RemoveEmptyEntries Or StringSplitOptions.TrimEntries)

            Dim value As Integer

            If Not Integer.TryParse(part, value) OrElse value < 0 Then
                ShowUsage()
            End If

            result.Add(value)

        Next

        If result.Count = 0 Then
            ShowUsage()
        End If

        Return result

    End Function


    Private Function MaximumRotationSum(numbers As List(Of Integer)) As Integer

        Dim n As Integer = numbers.Count

        If n = 0 Then
            ShowUsage()
        End If

        Dim totalSum As Integer = 0
        Dim currentWeightedSum As Integer = 0

        For i As Integer = 0 To n - 1
            totalSum += numbers(i)
            currentWeightedSum += numbers(i) * i
        Next

        Dim maxWeightedSum As Integer = currentWeightedSum

        For i As Integer = 1 To n - 1

            currentWeightedSum =
                currentWeightedSum + totalSum - n * numbers(n - i)

            If currentWeightedSum > maxWeightedSum Then
                maxWeightedSum = currentWeightedSum
            End If

        Next

        Return maxWeightedSum

    End Function


    Public Function Main(args As String()) As Integer

        If args.Length <> 1 Then
            ShowUsage()
        End If

        Dim inputList = ParseList(args(0))

        Console.WriteLine(MaximumRotationSum(inputList))

        Return 0

    End Function

End Module