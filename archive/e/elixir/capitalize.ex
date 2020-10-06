defmodule Capitalize do

    @doc """
    Capitalize the fitst entry of a list of strings and return the list as a single string.
    Return an error-string if the list is empty.
    """
    def main([]) do "Usage: please provide a string" end
     
    def main([ head | tail]) do
        [ String.capitalize(head) | tail ] |> Enum.join(" ")
    end

end

Capitalize.main(System.argv()) |> IO.puts