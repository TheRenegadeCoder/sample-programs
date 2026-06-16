case System.argv() do
  ["encode", str] when byte_size(str) > 0 ->
    Base.encode64(str) |> IO.puts()

  ["decode", str] when byte_size(str) > 0 ->
    case Base.decode64(str) do
      {:ok, res} -> IO.puts(res)
      _ -> IO.puts("Usage: please provide a mode and a string to encode/decode")
    end

  _ ->
    IO.puts("Usage: please provide a mode and a string to encode/decode")
end
