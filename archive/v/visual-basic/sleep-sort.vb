Imports System.Collections.Concurrent

Public Module SleepSort

    Private Sub ShowUsage()
        Console.WriteLine("Usage: please provide a list of at least two integers to sort in the format ""1, 2, 3, 4, 5""")
        Environment.Exit(1)
    End Sub

    Public Sub Main(args As String())

        If args.Length <> 1 Then
            ShowUsage()
        End If

        Try
            Dim xs = args(0).
                Split(","c, StringSplitOptions.RemoveEmptyEntries).
                Select(Function(i) Integer.Parse(i.Trim())).
                ToList()

            If xs.Count <= 1 Then
                ShowUsage()
            End If

            Dim sortedXs As New ConcurrentQueue(Of Integer)
            Dim tasks As New List(Of Task)

            For Each x In xs

                Dim captured = x

                tasks.Add(Task.Run(Async Function()
                                       Await Task.Delay(captured * 1000)
                                       sortedXs.Enqueue(captured)
                                   End Function))

            Next

            Task.WaitAll(tasks.ToArray())

            Console.WriteLine(String.Join(", ", sortedXs))

        Catch
            ShowUsage()
        End Try

    End Sub

End Module