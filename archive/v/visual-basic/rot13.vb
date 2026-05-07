Imports System.Text

Public Module Rot13

    Private Sub ShowUsage()
        Console.WriteLine("Usage: please provide a string to encrypt")
        Environment.Exit(1)
    End Sub


    Private Function EncryptChar(c As Char) As Char

        If c >= "A"c AndAlso c <= "Z"c Then
            Return ChrW(((AscW(c) - AscW("A"c) + 13) Mod 26) + AscW("A"c))
        End If

        If c >= "a"c AndAlso c <= "z"c Then
            Return ChrW(((AscW(c) - AscW("a"c) + 13) Mod 26) + AscW("a"c))
        End If

        Return c

    End Function


    Private Function Encrypt(input As String) As String

        Dim result As New StringBuilder(input.Length)

        For Each c As Char In input
            result.Append(EncryptChar(c))
        Next

        Return result.ToString()

    End Function


    Public Function Main(args As String()) As Integer

        If args Is Nothing OrElse args.Length = 0 OrElse String.IsNullOrEmpty(args(0)) Then
            ShowUsage()
        End If

        Console.WriteLine(Encrypt(args(0)))

        Return 0

    End Function

End Module