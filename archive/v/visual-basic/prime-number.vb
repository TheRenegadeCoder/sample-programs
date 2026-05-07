Public Module PrimeNumber

    Private Sub ShowUsage()
        Console.WriteLine("Usage: please input a non-negative integer")
        Environment.Exit(1)
    End Sub

    Private Function IsPrime(value As ULong) As Boolean

        If value <= 1UL Then Return False
        If value <> 2UL AndAlso value Mod 2UL = 0 Then Return False

        Dim limit As ULong = CULng(Math.Sqrt(value))

        Dim i As ULong = 3UL
        While i <= limit

            If value Mod i = 0UL Then
                Return False
            End If

            i += 2UL

        End While

        Return True

    End Function


    Public Function Main(args As String()) As Integer

        If args.Length <> 1 Then
            ShowUsage()
        End If

        Dim value As ULong

        If Not ULong.TryParse(args(0), value) Then
            ShowUsage()
        End If

        Console.WriteLine((If(IsPrime(value), "Prime", "Composite")))

        Return 0

    End Function

End Module