let has_odd_divisor_under_sqrt n =
  let rec aux k = k <= n / k && (n mod k = 0 || aux (k + 2)) in
  aux 3 (* Assumes n > 3. All other cases will be caught elsewhere *)

let prime = function
  | 0 | 1 -> false
  | 2 | 3 -> true
  | n when n mod 2 = 0 -> false
  | n -> not (has_odd_divisor_under_sqrt n)

let parse_args argv =
  match argv with [| _; n |] -> int_of_string_opt n | _ -> None

let () =
  print_endline
    (match parse_args Sys.argv with
    | Some num when num >= 0 -> if prime num then "Prime" else "Composite"
    | _ -> "Usage: please input a non-negative integer")
