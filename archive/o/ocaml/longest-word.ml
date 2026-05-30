(* Use custom function instead of Char.Ascii.is_white because the builtin also matches 
   on vertical tab and form feed which are not considered whitespace for the 
   purposes of this problem *)
let is_whitespace = function ' ' | '\t' | '\n' | '\r' -> true | _ -> false

let longest_word_len s =
  let best, _ =
    String.fold_left
      (fun (best, curr) c ->
        if is_whitespace c then (best, 0)
        else
          let curr = curr + 1 in
          (Int.max best curr, curr))
      (0, 0) s
  in
  best

let () =
  print_endline
  @@
  match Sys.argv with
  | [| _; s |] when s <> "" -> string_of_int (longest_word_len s)
  | _ -> "Usage: please provide a string"
