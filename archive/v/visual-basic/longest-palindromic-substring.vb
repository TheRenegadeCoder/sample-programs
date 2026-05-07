Public Module LongestPalindromicSubstring

    Public Sub Main(args As String())

        If args.Length <> 1 Then
            Console.WriteLine("Usage: please provide a string that contains at least one palindrome")
            Return
        End If

        Dim input As String = args(0)

        If String.IsNullOrWhiteSpace(input) Then
            Console.WriteLine("Usage: please provide a string that contains at least one palindrome")
            Return
        End If

        Dim result = LongestPalindrome(input)
        If result.Length < 2 Then
            Console.WriteLine("Usage: please provide a string that contains at least one palindrome")
            Return
        End If

        Console.WriteLine(result)

    End Sub


    Public Function LongestPalindrome(s As String) As String

        Dim t As String = Preprocess(s)

        Dim n As Integer = t.Length
        Dim p(n - 1) As Integer

        Dim center As Integer = 0
        Dim right As Integer = 0

        Dim maxLen As Integer = 0
        Dim maxCenter As Integer = 0

        For i As Integer = 1 To n - 2

            Dim mirror As Integer = 2 * center - i

            If i < right Then
                p(i) = Math.Min(right - i, p(mirror))
            End If

            While t(i + p(i) + 1) = t(i - p(i) - 1)
                p(i) += 1
            End While

            If i + p(i) > right Then
                center = i
                right = i + p(i)
            End If

            If p(i) > maxLen Then
                maxLen = p(i)
                maxCenter = i
            End If

        Next

        Dim startIndex As Integer = (maxCenter - maxLen) \ 2
        Return s.Substring(startIndex, maxLen)

    End Function


    Private Function Preprocess(s As String) As String

        Dim result As String = "^#"

        For Each c As Char In s
            result &= c & "#"
        Next

        result &= "$"

        Return result

    End Function

End Module