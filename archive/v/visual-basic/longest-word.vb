Public Module LongestWord
    Public Sub Main(args As String())
        ' Check if input is provided
        If args.Length = 0 Then
            Usage()
            Exit Sub
        End If

        ' Join the arguments to form the full input string
        Dim multi As String = String.Join(" ", args).Trim()

        ' Replace newlines, carriage returns, and tabs with spaces
        multi = multi.Replace(vbCrLf, " ").Replace(vbCr, " ").Replace(vbLf, " ").Replace(vbTab, " ")

        ' Split the string into words by spaces, removing empty entries
        Dim words As String() = multi.Split(" "c, StringSplitOptions.RemoveEmptyEntries)

        ' If there are no words, print usage
        If words.Length = 0 Then
            Usage()
            Exit Sub
        End If

        ' Find the longest word length
        Dim longestWord As String = ""
        Dim maxLength As Integer = 0

        ' Loop through the words and find the longest
        For Each word As String In words
            If word.Length > maxLength Then
                longestWord = word
                maxLength = word.Length
            End If
        Next

        ' Output the length of the longest word
        System.Console.WriteLine(maxLength)
    End Sub

    Public Sub Usage()
        System.Console.WriteLine("Usage: please provide a string")
    End Sub
End Module