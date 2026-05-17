let ( let* ) = Option.bind
let ( let+ ) f g = Option.map g f

let parse_list list_str =
  let rec aux acc l =
    match l with
    | [] -> Some (List.rev acc)
    | head :: rest ->
        let* num = head |> String.trim |> int_of_string_opt in
        aux (num :: acc) rest
  in
  list_str |> String.split_on_char ',' |> aux []

let parse_args argv =
  match argv with
  | [| _; nums; key |] ->
      let* parsed_nums = parse_list nums in
      let+ parsed_key = int_of_string_opt key in
      (parsed_nums, parsed_key)
  | _ -> None

let () =
  match parse_args Sys.argv with
  | Some (nums, key) -> Printf.printf "%b\n" (List.mem key nums)
  | _ ->
      print_endline
        {|Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")|}
