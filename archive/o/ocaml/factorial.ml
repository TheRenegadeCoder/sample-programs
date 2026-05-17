let factorial n =
  (* Use accumulator so OCaml can do tail call recursion *)
  let rec helper acc n =
    match n with 0 | 1 -> acc | n -> helper (acc * n) (n - 1)
  in
  helper 1 n

let parse_args argv =
  match argv with [| _; n |] -> int_of_string_opt n | _ -> None

let () =
  print_endline
    (match parse_args Sys.argv with
    | Some num when num >= 0 -> num |> factorial |> string_of_int
    | _ -> "Usage: please input a non-negative integer")
