(* This implementation performs a bottom-up merge sort*)
let ( let* ) = Option.bind

(* Given 2 sorted lists, merge them into a single sorted list *)
let merge a b =
  let rec aux acc a b =
    match (a, b) with
    (* If only one list has elements, append all of the remaining elements from that list *)
    | _, [] -> List.rev_append acc a
    | [], _ -> List.rev_append acc b
    (* If both lists have elements remaining, take the smaller of the two heads *)
    | a_head :: a_rest, b_head :: b_rest ->
        if a_head <= b_head then aux (a_head :: acc) a_rest b
        else aux (b_head :: acc) a b_rest
  in
  aux [] a b

(* Merge adjacent elements in a list using f
   For example, when f is merge and the input is
   [[1; 5]; [3; 8]; [4; 11]; [12; 15]] 
   the output would be
   [[1; 3; 5; 8]; [4; 11; 12; 15]] *)
let pair_map f list =
  let rec aux acc list =
    match list with
    (* If we have at least two elements to merge, merge them *)
    | first :: second :: rest -> aux (f first second :: acc) rest
    (* If we have an odd element out that cannot be paired, include it directly *)
    | [ first ] -> aux (first :: acc) []
    | [] -> List.rev acc
  in
  aux [] list

(* Recursively merge pairs until everything has been merged into a single list
   For example, repeated merges could go as follows:
   [[5]; [1]; [8]; [3]; [4]; [11]; [15]; [12]]
      [[1; 5]; [3, 8]; [4, 11]; [12; 15]] 
        [[1; 3; 5; 8]; [4; 11; 12; 15]]
         [[1; 3; 4; 5; 8; 11; 12; 15]]
          [1; 3; 4; 5; 8; 11; 12; 15]
   *)
let rec pair_collapse f list =
  match list with
  | [] -> []
  (* Once we have a single element, extract it from its nest *)
  | [ single ] -> single
  (* While we have at least two elements to merge, recursively merge them *)
  | list -> pair_collapse f (pair_map f list)

(* Convert input list into a list of singletons, then recursively merge sorted lists *)
let merge_sort list = pair_collapse merge (List.map List.singleton list)

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
  | None ->
      print_endline
        {|Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"|}
