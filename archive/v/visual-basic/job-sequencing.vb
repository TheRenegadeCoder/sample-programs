Public Class Job
    Public Property Profit As Integer
    Public Property Deadline As Integer

    Public Sub New(profit As Integer, deadline As Integer)
        Me.Profit = profit
        Me.Deadline = deadline
    End Sub
End Class


Public Module JobSequencing

    Public Sub Main(args As String())

        If args.Length <> 2 Then
            Console.WriteLine("Usage: please provide a list of profits and a list of deadlines")
            Return
        End If

        Dim profits = ParseIntList(args(0))
        Dim deadlines = ParseIntList(args(1))

        If profits Is Nothing OrElse deadlines Is Nothing OrElse
           profits.Count <> deadlines.Count Then

            Console.WriteLine("Usage: please provide a list of profits and a list of deadlines")
            Return
        End If

        Dim jobs As New List(Of Job)

        For i As Integer = 0 To profits.Count - 1
            jobs.Add(New Job(profits(i), deadlines(i)))
        Next

        Dim selected = GetMaxProfitJobSequence(jobs)

        Dim totalProfit As Integer = 0

        For Each job In selected
            totalProfit += job.Profit
        Next

        Console.WriteLine(totalProfit)

    End Sub


    Private Function ParseIntList(input As String) As List(Of Integer)

        If String.IsNullOrWhiteSpace(input) Then
            Return Nothing
        End If

        Dim result As New List(Of Integer)

        For Each part In input.Split(","c, StringSplitOptions.RemoveEmptyEntries)

            Dim value As Integer

            If Not Integer.TryParse(part.Trim(), value) Then
                Return Nothing
            End If

            result.Add(value)

        Next

        Return result

    End Function


    Public Function GetMaxProfitJobSequence(jobs As List(Of Job)) As List(Of Job)

        jobs.Sort(Function(a, b) b.Profit.CompareTo(a.Profit))

        Dim maxDeadline As Integer = 0

        For Each job In jobs
            If job.Deadline > maxDeadline Then
                maxDeadline = job.Deadline
            End If
        Next

        Dim timeSlots(maxDeadline - 1) As Boolean
        Dim selected As New List(Of Job)

        For Each job In jobs

            For i As Integer = job.Deadline - 1 To 0 Step -1

                If Not timeSlots(i) Then
                    timeSlots(i) = True
                    selected.Add(job)
                    Exit For
                End If

            Next

        Next

        Return selected

    End Function

End Module