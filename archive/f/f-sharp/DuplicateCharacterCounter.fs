open System

let usage = "Usage: please provide a string"

module DuplicateCharacterCounter =
    let private getDuplicateCounts =
        Seq.countBy id
        >> Seq.filter (fun (_, count) -> count > 1)
        >> Seq.map (fun (c, count) -> sprintf "%c: %d" c count)
        >> Seq.toList

    let private formatOutput =
        function
        | [] -> "No duplicate characters"
        | items -> String.concat "\n" items

    let run input =
        input |> getDuplicateCounts |> formatOutput |> Ok

module Helpers =
    let (|Empty|NonEmpty|) (s: string) =
        match s.Trim() with
        | "" -> Empty
        | trimmed -> NonEmpty trimmed

    let parseArgs argv =
        match argv with
        | [| Empty |] -> Error usage
        | [| NonEmpty input |] -> Ok input
        | _ -> Error usage

    let handleResults =
        function
        | Ok result ->
            printfn "%s" result
            0
        | Error msg ->
            eprintfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Result.bind DuplicateCharacterCounter.run
    |> Helpers.handleResults
