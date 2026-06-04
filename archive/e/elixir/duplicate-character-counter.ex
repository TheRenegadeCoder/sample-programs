case System.argv() do
  [str] when byte_size(str) > 0 ->
    chars = String.graphemes(str)

    frequencies = Enum.reduce(chars, %{}, fn el, acc ->
      Map.update(acc, el, 1, &(&1 + 1))
    end) |> Enum.filter(fn {_, count} -> count > 1 end) |> Map.new()

    if Enum.empty?(frequencies) do
      IO.puts("No duplicate characters")
    else
      chars
      |> Enum.uniq()
      |> Enum.each(fn char ->
        if Map.has_key?(frequencies, char) do
          IO.puts("#{char}: #{frequencies[char]}")
        end
      end)
    end
  _ -> IO.puts("Usage: please provide a string")
end
