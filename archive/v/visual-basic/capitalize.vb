Module Capitalize

    Sub Main(args As String())

        If args.Length = 0 OrElse String.IsNullOrWhiteSpace(args(0)) Then
            Console.WriteLine("Usage: please provide a string")
            Return
        End If

        Dim input = args(0)

        Dim output =
            Char.ToUpperInvariant(input(0)) &
            If(input.Length > 1, input.Substring(1), String.Empty)

        Console.WriteLine(output)

    End Sub

End Module