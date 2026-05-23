let even_odd n = if n mod 2 = 0 then "Even" else "Odd"
let parse_args = function [| _; n |] -> int_of_string_opt n | _ -> None

let () =
  print_endline
    (match parse_args Sys.argv with
    | Some num -> even_odd num
    | None -> "Usage: please input a number")
