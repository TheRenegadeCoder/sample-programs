Imports System.Text

Public Module DuplicateCharacterCounter

    Public Sub Main(args As String())

        If args.Length = 0 OrElse String.IsNullOrEmpty(args(0)) Then
            Console.WriteLine("Usage: please provide a string")
            Return
        End If

        Dim input As String = args(0)

        Dim countMap As New Dictionary(Of Char, Integer)

        For Each c As Char In input

            If countMap.ContainsKey(c) Then
                countMap(c) += 1
            Else
                countMap(c) = 1
            End If

        Next

        Dim result As New StringBuilder()
        Dim seen As New HashSet(Of Char)

        For Each c As Char In input

            If countMap(c) > 1 AndAlso Not seen.Contains(c) Then
                result.AppendLine($"{c}: {countMap(c)}")
                seen.Add(c)
            End If

        Next

        If result.Length = 0 Then
            Console.WriteLine("No duplicate characters")
        Else
            Console.WriteLine(result.ToString().TrimEnd())
        End If

    End Sub

End Module