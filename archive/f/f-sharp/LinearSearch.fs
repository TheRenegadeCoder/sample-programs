open System

module LinearSearch =
    let run (numbers: 'a list, target: 'a) =
        numbers
        |> List.exists ((=) target)
        |> Ok


module Helpers =
    let usage =
        "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"

    let private (|Int|_|) (s: string) =
        match s.Trim() |> Int32.TryParse with
        | true, n -> Some n
        | _ -> None

    let private (|IntList|_|) (s: string) =
        s.Split(',', StringSplitOptions.RemoveEmptyEntries)
        |> Array.toList
        |> List.choose (fun x ->
            match x.Trim() with
            | Int n -> Some n
            | _ -> None)
        |> function
            | [] -> None
            | xs -> Some xs


    let parseArgs argv =
        match argv with
        | [| IntList numbers; Int target |] -> Ok(numbers, target)
        | _ -> Error usage

    let handleResult =
        function
        | Ok result ->
            printfn "%b" result
            0
        | Error msg ->
            eprintfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Result.bind LinearSearch.run
    |> Helpers.handleResult
