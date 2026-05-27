with :ok <- File.write("output.txt", "Oh, hi Mark."),
     {:ok, contents} <- File.read("output.txt") do
  String.split(contents, "\n") |> Enum.each(&IO.puts/1)
else
  {:error, reason} -> :file.format_error(reason)
end
