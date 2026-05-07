Imports System
Imports System.Collections.Generic

Public Module LongestCommonSubsequence

    Public Sub Main(args As String())

        If args.Length < 2 Then
            ShowUsage()
            Return
        End If

        Dim list1 = Parse(args(0))
        Dim list2 = Parse(args(1))

        If list1 Is Nothing OrElse list2 Is Nothing Then
            ShowUsage()
            Return
        End If

        Dim result = LCS(list1, list2)

        Console.WriteLine(String.Join(", ", result))

    End Sub


    Private Function LCS(list1 As List(Of String),
                         list2 As List(Of String)) As List(Of String)

        If list1.Count = 0 OrElse list2.Count = 0 Then
            Return New List(Of String)
        End If

        If list1(0) = list2(0) Then

            Dim rest = LCS(list1.GetRange(1, list1.Count - 1),
                           list2.GetRange(1, list2.Count - 1))

            rest.Insert(0, list1(0))
            Return rest

        End If

        Dim option1 = LCS(list1, list2.GetRange(1, list2.Count - 1))
        Dim option2 = LCS(list1.GetRange(1, list1.Count - 1), list2)

        Return If(option1.Count >= option2.Count, option1, option2)

    End Function


    Private Function Parse(input As String) As List(Of String)

        If String.IsNullOrWhiteSpace(input) Then
            Return Nothing
        End If

        Dim result As New List(Of String)

        For Each part In input.Split(","c, StringSplitOptions.RemoveEmptyEntries)
            result.Add(part.Trim())
        Next

        Return result

    End Function


    Private Sub ShowUsage()
        Console.WriteLine(
            "Usage: please provide two lists in the format ""1, 2, 3, 4, 5"""
        )
        Environment.Exit(1)

    End Sub

End Module