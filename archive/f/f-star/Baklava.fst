module Baklava

open FStar.IO
open FStar.Math.Lib
open FStar.Mul

let baklava_line (n:nat {n <= 20}) : string =
  let num_spaces:nat = (abs (n - 10)) in
  let num_stars:nat = 21 - 2 * num_spaces in
  (String.make num_spaces ' ') ^ (String.make num_stars '*') ^ "\n"

let rec baklava (lines:string) (n:nat {n <= 20}) : string =
  match n with
  | 0 -> lines ^ (baklava_line 0)
  | _ -> lines ^ (baklava_line n) ^ (baklava lines (n - 1))

let main = print_string (baklava "" 20)
