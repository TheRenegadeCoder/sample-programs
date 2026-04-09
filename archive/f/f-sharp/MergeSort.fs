open System

module MergeSort =
    let rec private merge left right =
        let rec loop acc = function
            | [], rs | rs, [] -> List.rev acc @ rs
            | hL :: tL, hR :: tR ->
                match hL <= hR with
                | true  -> loop (hL :: acc) (tL, hR :: tR)
                | false -> loop (hR :: acc) (hL :: tL, tR)
        loop [] (left, right)

    let rec sort = function
        | [] | [ _ ] as trivial -> trivial
        | lst ->
            let mid         = lst.Length / 2
            let left, right = List.splitAt mid lst
            merge (sort left) (sort right)

module Result =
    let toOption = function
        | Ok x -> Some x
        | Error _ -> None

module Helpers =
    let private (|IntList|_|) (s: string) =
        let parts =
            s.Split(',', StringSplitOptions.RemoveEmptyEntries)
            |> Array.toList
            |> List.map (fun p -> p.Trim())

        let rec parseAll acc = function
            | [] -> Some(List.rev acc)
            | (h: string) :: t ->
                match Int32.TryParse h with
                | true, n -> parseAll (n :: acc) t
                | false, _ -> None

        parseAll [] parts
        |> function
            | Some ns when ns.Length >= 2 -> Some ns
            | _ -> None

    let parseArgs = function
        | [| IntList numbers |] -> Ok numbers
        | _ -> Error "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""

    let handleResult = function
        | Ok result ->
            result |> List.map string |> String.concat ", " |> printfn "%s"
            0
        | Error msg ->
            eprintfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv |> Helpers.parseArgs |> Result.map MergeSort.sort |> Helpers.handleResult
