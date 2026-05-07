Imports System.Text

Module Program

    Sub Main(args As String())

        If args.Length <> 2 Then
            ShowUsage()
            Return
        End If

        Dim mode = args(0).ToLowerInvariant()
        Dim value = args(1)

        If String.IsNullOrWhiteSpace(mode) OrElse String.IsNullOrWhiteSpace(value) Then
            ShowUsage()
            Return
        End If

        Select Case mode

            Case "encode"
                Console.WriteLine(
                    Convert.ToBase64String(
                        Encoding.UTF8.GetBytes(value)
                    )
                )

            Case "decode"
                Try
                    Console.WriteLine(
                        Encoding.UTF8.GetString(
                            Convert.FromBase64String(value)
                        )
                    )

                Catch ex As FormatException
                    ShowUsage()
                End Try

            Case Else
                ShowUsage()

        End Select

    End Sub

    Private Sub ShowUsage()
        Console.WriteLine("Usage: please provide a mode and a string to encode/decode")
    End Sub

End Module