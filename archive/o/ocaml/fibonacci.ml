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

let () =
  let nth_arg = List.nth_opt (Array.to_list Sys.argv) 1 in
  match Option.bind nth_arg int_of_string_opt with
  | Some num when num >= 0 -> fib_table num
  | _ ->
      print_endline
        "Usage: please input the count of fibonacci numbers to output"
