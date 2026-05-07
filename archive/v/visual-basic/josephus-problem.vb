Module JosephusProblem

    Public Sub Main(args As String())

        If args.Length < 2 Then
            Console.WriteLine("Usage: please input the total number of people and number of people to skip.")
            Return
        End If

        Dim n As Integer
        Dim k As Integer

        If Not Integer.TryParse(args(0), n) OrElse
           Not Integer.TryParse(args(1), k) OrElse
           n <= 0 OrElse k <= 0 Then

            Console.WriteLine("Usage: please input the total number of people and number of people to skip.")
            Return
        End If

        Dim survivor As Integer = Josephus(n, k)

        Console.WriteLine(survivor)

    End Sub


    Private Function Josephus(n As Integer, k As Integer) As Integer

        Dim result As Integer = 0

        For m As Integer = 2 To n
            result = (result + k) Mod m
        Next

        Return result + 1

    End Function

End Module