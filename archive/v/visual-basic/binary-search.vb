Imports System

Module BinarySearch

    Sub Main(args As String())

        If args.Length <> 2 Then
            ShowUsage()
            Return
        End If

        Dim list = ParseList(args(0))
        Dim target As Integer

        If list Is Nothing OrElse Not Integer.TryParse(args(1), target) Then
            ShowUsage()
            Return
        End If

        If Not IsSorted(list) Then
            ShowUsage()
            Return
        End If

        Console.WriteLine(BinarySearch(list, target))

    End Sub

    Private Function ParseList(input As String) As List(Of Integer)

        Dim result As New List(Of Integer)

        For Each part In input.Split(","c)

            Dim value As Integer

            If Not Integer.TryParse(part.Trim(), value) Then
                Return Nothing
            End If

            result.Add(value)

        Next

        Return result

    End Function

    Private Function BinarySearch(list As List(Of Integer), target As Integer) As Boolean

        Dim low = 0
        Dim high = list.Count - 1

        While low <= high

            Dim mid = (low + high) \ 2

            If list(mid) = target Then
                Return True
            ElseIf list(mid) < target Then
                low = mid + 1
            Else
                high = mid - 1
            End If

        End While

        Return False

    End Function

    Private Function IsSorted(list As List(Of Integer)) As Boolean

        For i = 0 To list.Count - 2
            If list(i) > list(i + 1) Then
                Return False
            End If
        Next

        Return True

    End Function

    Private Sub ShowUsage()
        Console.WriteLine(
            "Usage: please provide a list of sorted integers " &
            "(""1, 4, 5, 11, 12"") and the integer to find (""11"")"
        )
    End Sub

End Module