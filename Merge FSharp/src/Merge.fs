module Merge

let rec merge list1 list2 =
    match list1, list2 with
    | [], ys -> ys                     // If either list is empty, return the other
    | xs, [] -> xs
    | x::xs, y::ys when x <= y ->      // Compare heads of both lists
        x :: merge xs (y::ys)          // Take smaller element (x) and recurse
    | x::xs, y::ys ->
        y :: merge (x::xs) ys          // Otherwise take y and recurse    