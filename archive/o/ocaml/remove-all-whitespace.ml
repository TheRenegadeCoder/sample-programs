(* Use custom function instead of Char.Ascii.is_white because the builtin also matches 
   on vertical tab and form feed which are not considered whitespace for the 
   purposes of this problem *)
let is_whitespace = function ' ' | '\t' | '\n' | '\r' -> true | _ -> false

let remove_whitespace s =
  String.to_seq s |> Seq.filter (Fun.negate is_whitespace) |> String.of_seq

let () =
  print_endline
  @@
  match Sys.argv with
  | [| _; s |] when s <> "" -> remove_whitespace s
  | _ -> "Usage: please provide a string"
