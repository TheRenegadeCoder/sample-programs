defmodule TransposeMatrix do
  @doc """
  Transposes a matrix represented as a list of lists.
  """  
  @spec transpose_matrix(matrix :: list(list(integer()))) :: list(list(integer()))
  def transpose_matrix(matrix), do: Enum.zip(matrix) |> Enum.map(&Tuple.to_list/1)

  @spec parse_list(str :: String.t()) :: {:ok, list(integer())} | :error
  def parse_list(str) do
    res = str
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> Enum.reduce_while({:ok, []}, fn n, {:ok, acc} ->
        case Integer.parse(n) do
          {n, ""} -> {:cont, {:ok, [n | acc]}}
          _       -> {:halt, :error}
        end
      end)
    case res do
      {:ok, list} -> {:ok, Enum.reverse(list)}
      :error -> :error
    end
  end
end

with [cols, rows, matrix] <- System.argv(),
     {cols, ""} when cols > 0 <- Integer.parse(cols),
     {rows, ""} when rows > 0 <- Integer.parse(rows),
     {:ok, matrix} when rows * cols == length(matrix) <- TransposeMatrix.parse_list(matrix) do
  Enum.chunk_every(matrix, cols)
  |> TransposeMatrix.transpose_matrix()
  |> Enum.map(&Enum.join(&1, ", "))
  |> Enum.join(", ")
  |> IO.puts()
else
  _ -> IO.puts("Usage: please enter the dimension of the matrix and the serialized matrix")
end


     

