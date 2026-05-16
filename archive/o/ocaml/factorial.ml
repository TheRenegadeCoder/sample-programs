let factorial n = 
  (* Use accumulator so OCaml can do tail call recursion *)
  let rec helper acc n = 
    match n with
    | 0 | 1 -> acc
    | n -> helper (acc*n) (n-1)
  in
  helper 1 n

let () = print_endline (
  let nth_arg = List.nth_opt (Array.to_list Sys.argv) 1 in
  match Option.bind nth_arg int_of_string_opt with
  | Some num when num >= 0 -> num |> factorial |> string_of_int
  | _ -> "Usage: please input a non-negative integer"
)