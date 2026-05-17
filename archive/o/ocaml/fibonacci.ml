let fib n =
  let rec help current max out =
    if current > max then List.rev out
    else
      match out with
      | prev :: prevprev :: _ ->
          help (current + 1) max ((prev + prevprev) :: out)
      | _ -> help (current + 1) max (1 :: out)
  in
  help 1 n []

let fib_table n =
  List.iteri (fun i e -> Printf.printf "%d: %d\n" (i + 1) e) (fib n)

let parse_args argv =
  match argv with [| _; n |] -> int_of_string_opt n | _ -> None

let () =
  match parse_args Sys.argv with
  | Some num when num >= 0 -> fib_table num
  | _ ->
      print_endline
        "Usage: please input the count of fibonacci numbers to output"
