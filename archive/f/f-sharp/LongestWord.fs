open System

module LongestWord =
    let run (s: string) =
        s
        |> Seq.fold
            (fun (maxLen, currLen) ch ->
                if Char.IsWhiteSpace ch then
                    (max maxLen currLen, 0)
                else
                    (maxLen, currLen + 1))
            (0, 0)
        |> fun (maxLen, currLen) -> max maxLen currLen

module Helpers =
    let usage = "Usage: please provide a string"

    let parseArgs argv =
        match argv with
        | [| s |] when not (String.IsNullOrEmpty s) -> Ok s
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
    argv |> Helpers.parseArgs |> Result.map LongestWord.run |> Helpers.handleResult
