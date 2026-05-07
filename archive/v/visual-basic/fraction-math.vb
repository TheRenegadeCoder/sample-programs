Public Class FractionMath

    Private ReadOnly numerator As Integer
    Private ReadOnly denominator As Integer

    Public Sub New(Optional numerator As Integer = 0, Optional denominator As Integer = 1)

        If denominator = 0 Then
            Throw New ArgumentException("Denominator cannot be zero.")
        End If

        If denominator < 0 Then
            numerator = -numerator
            denominator = -denominator
        End If

        Dim gcdValue = GCD(Math.Abs(numerator), denominator)

        Me.numerator = numerator \ gcdValue
        Me.denominator = denominator \ gcdValue

    End Sub


    Private Shared Function GCD(x As Integer, y As Integer) As Integer

        While y <> 0
            Dim temp = x Mod y
            x = y
            y = temp
        End While

        Return x

    End Function


    Public Overrides Function ToString() As String
        Return $"{numerator}/{denominator}"
    End Function


    Public Shared Function Parse(value As String) As FractionMath

        If String.IsNullOrWhiteSpace(value) Then
            Throw New FormatException("Fraction cannot be empty.")
        End If

        Dim parts = value.Split("/"c)

        If parts.Length <> 2 Then
            Throw New FormatException("Expected format: numerator/denominator")
        End If

        Dim n As Integer
        Dim d As Integer

        If Not Integer.TryParse(parts(0), n) OrElse
           Not Integer.TryParse(parts(1), d) Then
            Throw New FormatException("Invalid integer in fraction.")
        End If

        Return New FractionMath(n, d)

    End Function


    Public Shared Operator +(a As FractionMath, b As FractionMath) As FractionMath
        Return New FractionMath(
            a.numerator * b.denominator + b.numerator * a.denominator,
            a.denominator * b.denominator
        )
    End Operator

    Public Shared Operator -(a As FractionMath, b As FractionMath) As FractionMath
        Return New FractionMath(
            a.numerator * b.denominator - b.numerator * a.denominator,
            a.denominator * b.denominator
        )
    End Operator

    Public Shared Operator *(a As FractionMath, b As FractionMath) As FractionMath
        Return New FractionMath(
            a.numerator * b.numerator,
            a.denominator * b.denominator
        )
    End Operator

    Public Shared Operator /(a As FractionMath, b As FractionMath) As FractionMath

        If b.numerator = 0 Then
            Throw New DivideByZeroException()
        End If

        Return New FractionMath(
            a.numerator * b.denominator,
            a.denominator * b.numerator
        )

    End Operator


    Private Function CompareTo(other As FractionMath) As Integer
        Dim left = CLng(numerator) * other.denominator
        Dim right = CLng(other.numerator) * denominator
        Return left.CompareTo(right)
    End Function


    Public Shared Operator =(a As FractionMath, b As FractionMath) As Boolean
        Return a.CompareTo(b) = 0
    End Operator

    Public Shared Operator <>(a As FractionMath, b As FractionMath) As Boolean
        Return a.CompareTo(b) <> 0
    End Operator

    Public Shared Operator >(a As FractionMath, b As FractionMath) As Boolean
        Return a.CompareTo(b) > 0
    End Operator

    Public Shared Operator <(a As FractionMath, b As FractionMath) As Boolean
        Return a.CompareTo(b) < 0
    End Operator

    Public Shared Operator >=(a As FractionMath, b As FractionMath) As Boolean
        Return a.CompareTo(b) >= 0
    End Operator

    Public Shared Operator <=(a As FractionMath, b As FractionMath) As Boolean
        Return a.CompareTo(b) <= 0
    End Operator
End Class


Public Module Program
    Private Sub ShowUsage()
        Console.WriteLine("Usage: ./fraction-math operand1 operator operand2")
        Environment.Exit(1)
    End Sub

    Public Sub Main(args As String())

        If args.Length <> 3 Then
            ShowUsage()
        End If

        Try

            Dim a = FractionMath.Parse(args(0))
            Dim op = args(1)
            Dim b = FractionMath.Parse(args(2))

            Select Case op

                Case "+"
                    Console.WriteLine(a + b)

                Case "-"
                    Console.WriteLine(a - b)

                Case "*"
                    Console.WriteLine(a * b)

                Case "/"
                    Console.WriteLine(a / b)

                Case "=="
                    Console.WriteLine(If(a = b, "1", "0"))

                Case "!="
                    Console.WriteLine(If(a <> b, "1", "0"))

                Case ">"
                    Console.WriteLine(If(a > b, "1", "0"))

                Case "<"
                    Console.WriteLine(If(a < b, "1", "0"))

                Case ">="
                    Console.WriteLine(If(a >= b, "1", "0"))

                Case "<="
                    Console.WriteLine(If(a <= b, "1", "0"))

                Case Else
                    ShowUsage()

            End Select

        Catch ex As Exception
            ShowUsage()
        End Try

    End Sub

End Module