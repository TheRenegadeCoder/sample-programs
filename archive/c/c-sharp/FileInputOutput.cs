using System.IO;

const string Path = "output.txt";
const string Content = """
line 1
line 2
line 3
""";

try
{
    File.WriteAllText(Path, Content);
    Console.WriteLine(File.ReadAllText(Path));
}
catch (IOException ex)
{
    Console.WriteLine($"IO error: {ex.Message}");
}