let max_2_fib_up_to n =
  let rec aux prev curr =
    if curr + prev > n then (curr, prev) else aux curr (prev + curr)
  in
  aux 1 1

let zeckendorf n =
  let rec aux high_f low_f rem acc =
    if rem = 0 then List.rev acc
    else
      let new_rem, new_acc =
        if high_f <= rem then (rem - high_f, high_f :: acc) else (rem, acc)
      in
      aux low_f (high_f - low_f) new_rem new_acc
  in
  let high_f, low_f = max_2_fib_up_to n in
  aux high_f low_f n []

let num_list_str nums = nums |> List.map string_of_int |> String.concat ", "

let parse_args argv =
  match argv with [| _; n |] -> int_of_string_opt n | _ -> None

let () =
  print_endline @@
  match parse_args Sys.argv with
  | Some num when num >= 0 -> num_list_str (zeckendorf num)
  | _ -> "Usage: please input a non-negative integer"
