Public Module Baklava
  Public Sub Main()
    Dim numSpaces As Integer
    For i As Integer = -10 To 10
        numSpaces = Math.Abs(i)
        System.Console.WriteLine(StrDup(numSpaces, " ") + StrDup(21 - 2 * numSpaces, "*"))
    Next i
  End Sub
End Module
