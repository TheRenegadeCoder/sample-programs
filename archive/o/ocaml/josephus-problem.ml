let ( let* ) = Option.bind

let num_list n =
  let rec aux acc i = if i = 0 then acc else aux (i :: acc) (i - 1) in
  aux [] n

let jo n k =
  let rec aux p l =
    match l with
    | [ s ] -> s
    | _ ->
        let killed = (p + k - 1) mod List.length l in
        aux
          (killed mod (List.length l - 1))
          (List.filteri (fun i _ -> i != killed) l)
  in
  aux 0 (num_list n)

let parse_args argv =
  match argv with
  | [| _; n; k |] ->
      let* parsed_n = int_of_string_opt n in
      let* parsed_k = int_of_string_opt k in
      Some (parsed_n, parsed_k)
  | _ -> None

let () =
  match parse_args Sys.argv with
  | Some (n, k) when n > 0 && k >= 0 -> print_endline (string_of_int (jo n k))
  | _ ->
      print_endline
        "Usage: please input the total number of people and number of people \
         to skip."
