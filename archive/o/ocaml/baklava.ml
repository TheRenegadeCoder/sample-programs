(** https://rosettacode.org/wiki/Repeat_a_string#OCaml **)
let string_repeat n s =
  String.concat "" (Array.to_list (Array.make n s));;

for n = -10 to 10 do
  let num_spaces = abs n in
  let num_stars = 21 - 2 * num_spaces in
  Printf.printf "%s%s\n" (string_repeat num_spaces " ") (string_repeat num_stars "*");
done
