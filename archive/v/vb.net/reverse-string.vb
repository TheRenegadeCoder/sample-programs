Public Module ReverseString
  Public Sub Main(args() As String)
    Dim input = String.Join(" ", args)

    If String.IsNullOrEmpty(input) Then
      Console.Write("Please provide some text to reverse: ")
      input = Console.ReadLine()
    End If

    Console.WriteLine($"Input: {input}")

    Dim reversedString = ReverseString(input)
    Console.WriteLine($"Reversed: {reversedString}")
  End Sub

  Public Function ReverseString(input As String) As String
    Dim chars = input.ToCharArray()

    Dim reversedChars(input.Length) As Char

    For i = 0 To chars.Length - 1
      reversedChars(input.Length - 1 - i) = chars(i)
    Next

    Return New String(reversedChars)
  End Function
End Module