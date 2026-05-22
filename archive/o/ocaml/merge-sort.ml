let ( let* ) = Option.bind

let split list =
  let rec aux acc slow fast =
    match (slow, fast) with
    | s :: s_rest, _ :: _ :: f_rest -> aux (s :: acc) s_rest f_rest
    | _, f_rest -> (List.rev acc, slow)
  in
  aux [] list list

let merge a b =
  let rec aux acc a b =
    match (a, b) with
    | _, [] -> List.rev_append acc a
    | [], _ -> List.rev_append acc b
    | a_head :: a_rest, b_head :: b_rest ->
        if a_head < b_head then aux (a_head :: acc) a_rest b
        else aux (b_head :: acc) a b_rest
  in
  aux [] a b

let rec merge_sort list =
  match list with
  | [] | [ _ ]-> list
  | _ :: _ ->
      let a, b = split list in
      merge (merge_sort a) (merge_sort b)

let parse_list list_str =
  let rec aux acc l =
    match l with
    | [] -> Some (List.rev acc)
    | head :: rest ->
        let* num = head |> String.trim |> int_of_string_opt in
        aux (num :: acc) rest
  in
  list_str |> String.split_on_char ',' |> aux []

let parse_args = function [| _; nums |] -> parse_list nums | _ -> None

let validate_args args =
  let* nums = parse_args args in
  match nums with [ _ ] -> None | _ -> Some nums

let print_list l =
  l |> List.map string_of_int |> String.concat ", " |> print_endline

let () =
  match validate_args Sys.argv with
  | Some nums -> print_list (merge_sort nums)
  | _ ->
      print_endline
        {|Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"|}
