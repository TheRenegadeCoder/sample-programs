Public Module ReverseString
  Public Sub Main(args() As String)
    Dim input = String.Empty
    If args IsNot Nothing Then
      input = String.Join(" ", args)
    End If

    If String.IsNullOrEmpty(input) Then
      System.Console.Write("Please provide some text to reverse: ")
      input = System.Console.ReadLine()
    End If

    System.Console.WriteLine($"Input: {input}")

    Dim reversedString = ReverseString(input)
    System.Console.WriteLine($"Reversed: {reversedString}")
  End Sub

  Public Function ReverseString(input As String) As String
    Dim chars = input.ToCharArray()

    System.Console.WriteLine(chars.Length)

    Dim reversedChars(input.Length) As Char

    For i = 0 To chars.Length - 1
      reversedChars(input.Length - 1 - i) = chars(i)
    Next

    Return New String(reversedChars)
  End Function
End Module