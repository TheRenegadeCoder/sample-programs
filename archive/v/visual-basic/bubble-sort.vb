Public Module BubbleSort
    Public Sub Main()
        Dim sortArray(9) As Integer
        sortArray(0) = 100
        sortArray(1) = 20
        sortArray(2) = 30
        sortArray(3) = 70
        sortArray(4) = 10
        sortArray(5) = 40
        sortArray(6) = 90
        sortArray(7) = 80
        sortArray(8) = 60
        sortArray(9) = 50
        sortArray = BubbleSort(sortArray)
        Dim outputSorted As String = String.Join(", ", sortArray)
        System.Console.WriteLine($"Sorted: {outputSorted}")
    End Sub

    Public Function BubbleSort(sortArray As Integer())
        Dim holdInt
        For i = 0 To UBound(sortArray)
            For x = UBound(sortArray) To i + 1 Step -1
                If sortArray(x) < sortArray(i) Then
                    holdInt = sortArray(x)
                    sortArray(x) = sortArray(i)
                    sortArray(i) = holdInt
                End If
            Next x
        Next i
        Return sortArray
    End Function
End Module
