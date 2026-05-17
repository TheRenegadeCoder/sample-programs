let ( let* ) = Option.bind

let palindrome str =
  let rec aux lo hi =
    lo >= hi || (str.[lo] = str.[hi] && aux (lo + 1) (hi - 1))
  in
  aux 0 (String.length str - 1)

let validate_arg argv =
  match argv with
  | [| _; n |] ->
      let* num = int_of_string_opt n in
      if num >= 0 then
        (* Converting back and forth normalizes the number 
           - allows for checking things like "+323" based on the actual numerical value *)
        (* Problem statement is underspecified, so going to follow Postel's law and be permissive :) *)
        Some (string_of_int num)
      else None
  | _ -> None

let () =
  match validate_arg Sys.argv with
  | Some n -> Printf.printf "%b\n" (palindrome n)
  | None -> print_endline "Usage: please input a non-negative integer"
