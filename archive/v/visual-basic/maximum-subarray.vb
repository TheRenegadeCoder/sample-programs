Public Module MaximumSubarray

    Private Sub ShowUsage()
        Console.Error.WriteLine(
            "Usage: Please provide a list of integers in the format: ""1, 2, 3, 4, 5"""
        )
        Environment.Exit(1)
    End Sub


    Private Function ParseIntegerList(input As String) As List(Of Integer)

        If String.IsNullOrWhiteSpace(input) Then
            ShowUsage()
        End If

        Dim result As New List(Of Integer)

        For Each part In input.Split(","c, StringSplitOptions.RemoveEmptyEntries Or StringSplitOptions.TrimEntries)

            Dim value As Integer

            If Not Integer.TryParse(part, value) Then
                ShowUsage()
            End If

            result.Add(value)

        Next

        If result.Count = 0 Then
            ShowUsage()
        End If

        Return result

    End Function


    Private Function MaximumSubarraySum(numbers As List(Of Integer)) As Integer

        If numbers.Count = 0 Then
            Return 0
        End If

        Dim currentSum As Integer = numbers(0)
        Dim maxSum As Integer = numbers(0)

        For i As Integer = 1 To numbers.Count - 1

            Dim value As Integer = numbers(i)

            currentSum = Math.Max(value, currentSum + value)
            maxSum = Math.Max(maxSum, currentSum)

        Next

        Return maxSum

    End Function


    Public Function Main(args As String()) As Integer

        If args.Length <> 1 Then
            ShowUsage()
        End If

        Dim inputList = ParseIntegerList(args(0))

        Console.WriteLine(MaximumSubarraySum(inputList))

        Return 0

    End Function

End Module