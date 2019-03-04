At any rate, let’s dive right into Hello World in Visual Basic .NET:

Public Module HelloWorld
  Public Sub Main()
    System.Console.WriteLine("Hello, World!")
  End Sub
End Module
As we can see, VB.NET is a structured language. In other words, there’s a very strong focus on code blocks and control flow structures.

Our first code block is the module declaration. In this case, we’ve declared a public module called HelloWorld. If other libraries needed access to this module, they could simply import it by name.

Next, we have our typical main function declaration. Of course, in VB.NET, we call them subroutines rather than functions—as indicated by the Sub keyword.

Finally, we have our print line. Much like languages like Java, we have to string together a few references before we can actually write to the console. In other words, we have to call WriteLine after we get a reference to the standard output class from the System namespace.

How to Run the Solution
With our solution implemented, we should probably give it a run. Perhaps the easiest way to run the solution is to copy it into an online VB.NET compiler.

Alternatively, we can run the solution using Microsoft’s very own Visual Studio. Of course, I’m not sure of it’s support on platforms beyond Windows. Don’t forget to grab a copy of the Hello World in Visual Basic .NET solution.
