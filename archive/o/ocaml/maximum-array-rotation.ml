let ( let* ) = Option.bind

(* Returns a tuple of:
   - length of list
   - unweighted sum of elements
   - sum of elements weighted by index *)
let list_sums nums =
  List.fold_left
    (fun (i, u_sum, w_sum) x -> (i + 1, u_sum + x, (i * x) + w_sum))
    (0, 0, 0) nums

(* Returns the best weighted sum across any rotation *)
let best_sum nums =
  let len, u_sum, w_sum = list_sums nums in
  let rec aux best prev_sum nums =
    match nums with
    | head :: rest ->
        (* Shift to the left: element 0 now gets full weight,
           all other elements get 1x less weight *)
        let cand = prev_sum - u_sum + (len * head) in
        aux (max best cand) cand rest
    | [] -> best
  in
  aux w_sum w_sum nums

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

let () =
  print_endline
  @@
  match parse_args Sys.argv with
  | Some nums -> nums |> best_sum |> string_of_int
  | None -> {|Usage: please provide a list of integers (e.g. "8, 3, 1, 2")|}
