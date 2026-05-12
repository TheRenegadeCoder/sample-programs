const int Height = 10;
const char Symbol = '*';

Span<char> stars = stackalloc char[Height * 2 + 1];
stars.Fill(Symbol);

static void PrintRow(int level, int height, ReadOnlySpan<char> stars)
{
    Console.Write(new string(' ', height - level));
    Console.WriteLine(stars[..(level * 2 + 1)]);
}

for (int i = 0; i < Height; i++)
    PrintRow(i, Height, stars);

for (int i = Height; i >= 0; i--)
    PrintRow(i, Height, stars);
