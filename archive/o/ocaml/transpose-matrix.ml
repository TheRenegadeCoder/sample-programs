let ( let* ) = Option.bind
let ( let+ ) f g = Option.map g f

let separate_first_col mat =
  let rec aux col_acc rest_mat_acc mat =
    match mat with
    | [] -> Some (List.rev col_acc, List.rev rest_mat_acc)
    | (head :: rest) :: rest_rows ->
        aux (head :: col_acc) (rest :: rest_mat_acc) rest_rows
    | _ -> None
  in
  aux [] [] mat

let transpose mat =
  let rec aux acc mat =
    match mat with
    | [] :: _ ->
        if List.for_all List.is_empty mat then Some (List.rev acc) else None
    | _ ->
        let* col, rem = separate_first_col mat in
        aux (col :: acc) rem
  in
  aux [] mat

let split_at n list =
  let rec aux acc n list =
    match (n, list) with
    | 0, _ | _, [] -> (List.rev acc, list)
    | _, head :: rest -> aux (head :: acc) (n - 1) rest
  in
  aux [] n list

let to_matrix ~rows ~cols nums =
  if rows <= 0 || cols <= 0 || rows * cols <> List.length nums then None
  else
    let rec aux acc nums =
      match split_at cols nums with
      | row, [] -> Some (List.rev (row :: acc))
      | row, rest -> aux (row :: acc) rest
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
  | [| _; cols; rows; nums |] ->
      let* parsed_cols = int_of_string_opt cols in
      let* parsed_rows = int_of_string_opt rows in
      let* parsed_nums = parse_list nums in
      Some (parsed_cols, parsed_rows, parsed_nums)
  | _ -> None

let flat_mat_str mat =
  mat |> List.flatten |> List.map string_of_int |> String.concat ", "

let print_flat_mat_trans_str ~rows ~cols nums =
  let output_list_str =
    let* mat = to_matrix ~rows ~cols nums in
    let+ trans = transpose mat in
    flat_mat_str trans
  in
  match output_list_str with
  | None -> print_endline "Matrix did not match specified dimensions"
  | Some output_list_str -> print_endline output_list_str

let () =
  match parse_args Sys.argv with
  | Some (cols, rows, nums) when cols > 0 && rows > 0 ->
      print_flat_mat_trans_str ~rows ~cols nums
  | _ ->
      print_endline
        "Usage: please enter the dimension of the matrix and the serialized \
         matrix"
