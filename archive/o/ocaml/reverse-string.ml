let reverse s =
  let len = String.length s in
  String.init len (fun i -> s.[len - i - 1])

let () =
  print_endline
    (match Sys.argv with [||] | [| _ |] -> "" | args -> reverse args.(1))
(* Any additional arguments are ignored, following the example of other samples in this repo *)
