let rot_char range_start_c range_size n c =
  let range_start_num = Char.code range_start_c in
  Char.chr
    (((Char.code c - range_start_num + n) mod range_size) + range_start_num)

let rot_if_letter n c =
  match c with
  | 'a' .. 'z' -> rot_char 'a' 26 n c
  | 'A' .. 'Z' -> rot_char 'A' 26 n c
  | _ -> c

let rot n s = String.map (rot_if_letter n) s

let () =
  print_endline
  @@
  match Sys.argv with
  | [| _; s |] when s <> "" -> rot 13 s
  | _ -> "Usage: please provide a string to encrypt"
