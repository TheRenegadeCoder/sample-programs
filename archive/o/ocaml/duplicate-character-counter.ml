module CharMap = Map.Make (Char)

let increment_map (counts, seen) k =
  match CharMap.find_opt k counts with
  | Some n -> (CharMap.add k (n + 1) counts, seen)
  | None -> (CharMap.add k 1 counts, k :: seen)

let count_chars str =
  str |> String.to_seq |> Seq.fold_left increment_map (CharMap.empty, [])

let dupes str =
  let counts, seen = count_chars str in
  seen |> List.rev
  |> List.filter_map (fun c ->
      let count = CharMap.find c counts in
      if count > 1 then Some (c, count) else None)

let print_dupes str =
  match dupes str with
  | [] -> print_endline "No duplicate characters"
  | counts ->
      List.iter (fun (c, count) -> Printf.printf "%c: %d\n" c count) counts

let get_arg argv =
  match argv with [| _; "" |] -> None | [| _; str |] -> Some str | _ -> None

let () =
  match get_arg Sys.argv with
  | Some str -> print_dupes str
  | None -> print_endline "Usage: please provide a string"
