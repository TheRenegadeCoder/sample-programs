let ( let* ) = Option.bind

let josephus n k =
  let rec aux curr people =
    match people with
    | [ survivor ] -> survivor
    | _ ->
        let len = List.length people in
        let killed = (curr + k - 1) mod len in
        aux
          (killed mod (len - 1))
          (List.filteri (fun i _ -> i <> killed) people)
  in
  aux 0 (List.init n (fun i -> i + 1))

let parse_args argv =
  match argv with
  | [| _; n; k |] ->
      let* parsed_n = int_of_string_opt n in
      let* parsed_k = int_of_string_opt k in
      Some (parsed_n, parsed_k)
  | _ -> None

let () =
  match parse_args Sys.argv with
  | Some (n, k) when n > 0 && k >= 0 ->
      print_endline (string_of_int (josephus n k))
  | _ ->
      print_endline
        "Usage: please input the total number of people and number of people \
         to skip."
