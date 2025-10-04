Public Module ReverseString
  Public Sub Main(args() As String)
    Dim input = String.Empty
    If args IsNot Nothing Then
      input = String.Join(" ", args)
    End If

    System.Console.WriteLine(ReverseString(input))
  End Sub

    Public Function ReverseString(ByVal input As String) As String
        Dim chars() As Char = input.ToCharArray()
        Array.Reverse(chars)
        Return New String(chars)
    End Function
End Module
