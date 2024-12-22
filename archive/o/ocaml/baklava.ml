(** https://stackoverflow.com/questions/46370362/recursive-function-to-repeat-string-in-ocaml **)
let rec string_repeat n s =
  if n < 1 then "" else s ^ string_repeat (n - 1) s;;

for n = -10 to 10 do
  let num_spaces = abs n in
  let num_stars = 21 - 2 * num_spaces in
  Printf.printf "%s%s\n" (string_repeat num_spaces " ") (string_repeat num_stars "*");
done
