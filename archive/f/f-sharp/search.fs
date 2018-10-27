let search element list =
  List.exists (List.filter (fun x -> (x = element)) list);;
