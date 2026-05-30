let ( let* ) = Option.bind
let ( let+ ) f g = Option.map g f

let rem_col mat = let* (first_col, remaining) = List.fold_left (fun acc x -> 
  let* (col, rest_mat) = acc in
  match x with 
  | [] -> None
  | head::rest -> Some (head::col, rest::rest_mat)) (Some ([], [])) mat
in
Some (List.rev first_col, List.rev remaining)

let transpose mat =
  let rec aux acc mat =
    match mat with
    | []::_ -> let+ acc = acc in List.rev acc
    | _ -> let* acc = acc in let* (col, rem) = rem_col mat in aux (Some (col :: acc)) rem
  in
  aux (Some []) mat

let to_matrix cols nums = 
  let rec aux acc nums = 
    match nums with
    | [] -> Some (List.rev acc)
    | _ when List.length nums < cols -> None
    | _ -> aux ((List.take cols nums) :: acc) (List.drop cols nums)
  in
  aux [] nums

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
  | [| _; cols; rows; nums;|] ->
      let* parsed_cols = int_of_string_opt cols in
      let* parsed_rows = int_of_string_opt rows in
      let* parsed_nums = parse_list nums in
      Some (parsed_cols, parsed_cols, parsed_nums)
  | _ -> None

let flat_mat_str mat = mat |> List.flatten |> List.map string_of_int |> String.concat ", "

let print_flat_mat_trans_str cols nums = 
  let output_list_str =
  let* mat = to_matrix cols nums in
  let+ trans = transpose mat in
  flat_mat_str trans
  in match output_list_str with
  | None -> print_endline
        "Matrix did not match specified dimensions"
  | Some output_list_str -> print_endline output_list_str

let () =
  match parse_args Sys.argv with
  | Some (cols, rows, nums) -> print_flat_mat_trans_str cols nums
  | _ ->
      print_endline
        "Usage: please enter the dimension of the matrix and the serialized matrix"