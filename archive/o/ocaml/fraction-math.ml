let ( let* ) = Option.bind

type rat = { num : int; denom : int }

let gcd a b =
  let a = abs a in
  let b = abs b in
  let rec aux a b =
    let r = a mod b in
    if r = 0 then b else aux b r
  in
  aux a b

let simplify { num; denom } =
  let div = gcd num denom in
  let sign_flip = if denom < 0 then -1 else 1 in
  { num = num / div * sign_flip; denom = denom / div * sign_flip }

let to_string { num; denom } = string_of_int num ^ "/" ^ string_of_int denom
let recip { num; denom } = { num = denom; denom = num }
let mult a b = simplify { num = a.num * b.num; denom = a.denom * b.denom }
let div a b = mult a (recip b)

let add a b =
  simplify
    { num = (a.num * b.denom) + (b.num * a.denom); denom = a.denom * b.denom }

let sub a b = add a { num = -b.num; denom = b.denom }

let common_denom a b =
  let denom = a.denom * b.denom in
  ({ num = a.num * b.denom; denom }, { num = b.num * a.denom; denom })

let eq a b = simplify a = simplify b
let neq a b = not (eq a b)

let gt a b =
  let { num = a_num; _ }, { num = b_num; _ } =
    common_denom (simplify a) (simplify b)
  in
  a_num > b_num

let gte a b = gt a b || eq a b
let lt a b = not (gte a b)
let lte a b = lt a b || eq a b

let parse_frac s =
  match String.split_on_char '/' s with
  | [ num; denom ] ->
      let* num_int = int_of_string_opt num in
      let* denom_int = int_of_string_opt denom in
      if denom_int <> 0 then Some { num = num_int; denom = denom_int } else None
  | _ -> None

module StringMap = Map.Make (String)

type frac_op = Arith of (rat -> rat -> rat) | Bool of (rat -> rat -> bool)

let ops =
  StringMap.of_list
    [
      ("*", Arith mult);
      ("/", Arith div);
      ("+", Arith add);
      ("-", Arith sub);
      ("==", Bool eq);
      ("!=", Bool neq);
      (">", Bool gt);
      ("<", Bool lt);
      (">=", Bool gte);
      ("<=", Bool lte);
    ]

let exec_exp a op b =
  match op with
  | Arith f -> f a b |> to_string
  | Bool f -> if f a b then "1" else "0"

let parse_args = function
  | [| _; a; op_s; b |] ->
      let* op_f = StringMap.find_opt op_s ops in
      let* a_rat = parse_frac a in
      let* b_rat = parse_frac b in
      Some (a_rat, op_f, b_rat)
  | _ -> None

let () =
  print_endline
  @@
  match parse_args Sys.argv with
  | Some (a, op, b) -> exec_exp a op b
  | _ -> "Usage: ./fraction-math operand1 operator operand2"
