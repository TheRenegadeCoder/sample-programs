open System

module MaximumSubarray =
    let run =
        Array.fold (fun (currentMax, globalMax) x ->
            let x = int64 x
            let newCurrent = max x (currentMax + x)
            (newCurrent, max globalMax newCurrent)
        ) (0L, Int64.MinValue)
        >> snd

module Helpers =
    let usage =
        "Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\""

    let private (|IntArray|_|) (s: string) =
        let parts = s.Split(',', StringSplitOptions.RemoveEmptyEntries)

        let rec parseAll i acc =
            if i = parts.Length then
                List.rev acc |> List.toArray |> Some
            else
                match parts[i] |> _.Trim() |> Int32.TryParse with
                | true, n -> parseAll (i + 1) (n :: acc)
                | false, _ -> None

        if parts.Length = 0 then None else parseAll 0 []

    let parseArgs argv =
        match argv with
        | [| IntArray numbers |] -> Ok(numbers)
        | _ -> Error usage

    let handleResult =
        function
        | Ok result ->
            printfn "%d" result
            0
        | Error msg ->
            eprintfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Result.map MaximumSubarray.run
    |> Helpers.handleResult