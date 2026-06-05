let ( let* ) = Option.bind
let ( let+ ) f g = Option.map g f

(* 
  Splits a matrix into a list containing its first column and the remainder of the matrix
  Returns None if any of the rows has no elements, which would indicate a malformed matrix.

  Example input:
  [[1;2;3];
   [4;5;6];
   [7;8;9]
  ]
  Example output
  [1;4;7], [[2;3];
            [5;6];
            [8;9]]
*)
let separate_first_col mat =
  (* Recurses over each row of the matrix, accumulating
     the extracted column and remainder of the matrix*)
  let rec aux col_acc rest_mat_acc mat =
    match mat with
    (* If finished with all rows of matrix, return accumulated values *)
    | [] -> Some (List.rev col_acc, List.rev rest_mat_acc)
    (* If the current row has at least one value, extract it and move to next row *)
    | (head :: rest) :: rest_rows ->
        aux (head :: col_acc) (rest :: rest_mat_acc) rest_rows
    (* If the current row has no values, the matrix is malformed *)
    | _ -> None
  in
  aux [] [] mat

(* Returns the transpose of the matrix or None if the matrix is ragged.
   The robustness against raggedness is not strictly needed for this problem
   as the argument parsing ensures a well-formed matrix, but it is included
   to demonstrate how a library transpose might defend against malformed input.*)
let transpose mat =
  (* Recurse over columns of the matrix, stacking them as rows *)
  let rec aux acc mat =
    match mat with
    (* If we have exhausted the first row*)
    | [] :: _ ->
        (* If any remaining rows still have values, the matrix is malformed,
           else return the accumulated transposed matrix *)
        if List.for_all List.is_empty mat then Some (List.rev acc) else None
    (* If there are still remaining elements in the first row *)
    | _ ->
        (* Take the first column and stack it as a row in the new matrix*)
        let* col, rem = separate_first_col mat in
        aux (col :: acc) rem
  in
  aux [] mat

(* Splits a list in two at the given index. If the given index is >= the length,
the second list will be empty *)
let split_at n list =
  let rec aux acc n list =
    match (n, list) with
    | 0, _ | _, [] -> (List.rev acc, list)
    | _, head :: rest -> aux (head :: acc) (n - 1) rest
  in
  aux [] n list

(* Converts a list of ints into a matrix given the number of rows and columns. 
   Returns None if invalid rows/cols are passed or the length of the list
   does not match the size of the matrix. *)
let to_matrix ~rows ~cols nums =
  if rows <= 0 || cols <= 0 || rows * cols <> List.length nums then None
  else
    (* Recursively chop off the first `cols` elements to make a row and stack them
       to make the matrix *)
    let rec aux acc nums =
      match split_at cols nums with
      | row, [] -> Some (List.rev (row :: acc))
      | row, rest -> aux (row :: acc) rest
    in
    aux [] nums

(* Converts a comma and space delimited string of numbers into a list of those numbers
   or returns None if there is an error in parsing *)
let parse_list list_str =
  let rec aux acc l =
    match l with
    | [] -> Some (List.rev acc)
    | head :: rest ->
        let* num = head |> String.trim |> int_of_string_opt in
        aux (num :: acc) rest
  in
  list_str |> String.split_on_char ',' |> aux []

(* Parses arguments, assuming:
   program_name cols rows nums
   Note the non-standard ordering of cols before rows, as is required in
   the problem statement. *)
let parse_args argv =
  match argv with
  | [| _; cols; rows; nums |] ->
      let* parsed_cols = int_of_string_opt cols in
      let* parsed_rows = int_of_string_opt rows in
      let* parsed_nums = parse_list nums in
      Some (parsed_cols, parsed_rows, parsed_nums)
  | _ -> None

(* Converts a matrix into a string representing a list of numbers *)
let flat_mat_str mat =
  mat |> List.flatten |> List.map string_of_int |> String.concat ", "

let print_flat_mat_trans_str ~rows ~cols nums =
  let output_list_str =
    let* mat = to_matrix ~rows ~cols nums in
    let+ trans = transpose mat in
    flat_mat_str trans
  in
  match output_list_str with
  (* This error is technically not required in the problem statement,
     but it is added for robustness *)
  | None -> print_endline "Matrix did not match specified dimensions"
  | Some output_list_str -> print_endline output_list_str

let () =
  match parse_args Sys.argv with
  | Some (cols, rows, nums) when cols > 0 && rows > 0 ->
      (* Flip col/row order from input to row/col to match typical
         matrix convention. Named arguments are used to assure reader
         this flip is intentional. *)
      print_flat_mat_trans_str ~rows ~cols nums
  | _ ->
      print_endline
        "Usage: please enter the dimension of the matrix and the serialized \
         matrix"
