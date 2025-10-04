Public Module BubbleSort
    Public Sub Main(args As String())
        Try
            ' Convert string to array of integers
            Dim listOfStringInputs As String() = args(0).Split(",")
            Dim n as Integer = UBound(listOfStringInputs)
            If n < 2
                Usage()
                Exit Sub
            End If
    
            Dim sortArray(n) As Integer
            For i As Integer = 0 To n
                sortArray(i) = Integer.Parse(listOfStringInputs(i))
            Next i

            ' Sort array
            BubbleSort(sortArray)
            
            ' Display array
            Dim first As Boolean = True
            For i As Integer = 0 To n
                If i <> 0
                    System.Console.Write(", ")
                End If
                    
                System.Console.Write(sortArray(i))
            Next i
            System.Console.WriteLine()
        Catch e As FormatException
            Usage()
        Catch e As IndexOutOfRangeException
            Usage()
        End Try
    End Sub

    Public Sub Usage()
        System.Console.WriteLine("Usage: please provide a list of at least two integers to sort in the format ""1, 2, 3, 4, 5""")
    End Sub

    Public Sub BubbleSort(ByRef sortArray As Integer())
        Dim holdInt As Integer
        Dim n As Integer = UBound(sortArray)
        For i As Integer = 0 To n - 1
            For x As Integer = i + 1 To n
                If sortArray(x) < sortArray(i) Then
                    holdInt = sortArray(x)
                    sortArray(x) = sortArray(i)
                    sortArray(i) = holdInt
                End If
            Next x
        Next i
    End Sub
End Module
