let ( let* ) = Option.bind

let init_sum nums =
  let _, sum =
    Array.fold_left (fun (i, sum) x -> (i + 1, (i * x) + sum)) (0, 0) nums
  in
  sum

let best_sum nums =
  let len = Array.length nums in
  let rec aux best i prev_u prev =
    if i = len then best
    else
      let f = nums.((len - i + 1) mod len) in
      let e = nums.(len - i) in
      let cand = prev + prev_u - (len * e) + f in
      let unweighted = prev_u - e + f in
      aux (max best cand) (i + 1) unweighted cand
  in
  let start = init_sum nums in
  let init_sum_unweighted = Array.fold_left ( + ) 0 nums - nums.(0) in
  aux start 1 init_sum_unweighted start

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
  | Some nums -> nums |> Array.of_list |> best_sum |> string_of_int
  | None -> {|Usage: please provide a list of integers (e.g. "8, 3, 1, 2")|}
