defmodule EvenOdd do
    require Integer

    @doc """
    Determine whether a supplied number is Even or Odd.
    Return an error-string if the argument is missing or invalid. 
    """
    @spec main(argv :: list( String.t())) :: String.t()
    def main(argv) do
        if length(argv) != 1 do
            "Usage: please input a number"
        else 
            case argv |> List.first |> Integer.parse do
                {number, ""} -> even_odd_string(number)
                {_, _rest} -> "Usage: please input a number"
                :error -> "Usage: please input a number"
            end
        end
    end

    @spec even_odd_string(number :: integer) :: String.t()
    defp even_odd_string(number) do
        case Integer.is_even(number) do
            true -> "Even"
            false -> "Odd"
        end
    end
end

EvenOdd.main(System.argv()) |> IO.puts