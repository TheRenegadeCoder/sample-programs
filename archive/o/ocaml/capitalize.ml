let () = print_endline (
  match Array.to_list Sys.argv with
  | [] | [_] | [_; ""] -> "Usage: please provide a string"
  | _::args -> args |> String.concat " " |> String.capitalize_ascii)