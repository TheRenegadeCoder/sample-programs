Imports System.IO

Module FileInputOutput

    Private Const FileName As String = "output.txt"
    Private Const Content As String = "Hello from VB.NET!"

    Public Sub WriteFile()
        File.WriteAllText(FileName, Content)
    End Sub

    Public Function ReadFile() As String
        Return File.ReadAllText(FileName)
    End Function

    Public Sub Main()

        Try
            WriteFile()
            Console.WriteLine(ReadFile())
        Catch ex As Exception
            Console.WriteLine($"File operation failed: {ex.Message}")
        End Try

    End Sub

End Module