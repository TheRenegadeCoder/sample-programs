open System

module Capitalizer =
    let private capitalize (input: string) =
        let chars = input.ToCharArray()
        chars.[0] <- Char.ToUpper chars.[0]
        String chars

    let run input = capitalize input |> Ok

module Helpers =
    let private (|NonEmptyString|_|) (s: string) =
        if String.IsNullOrWhiteSpace s then None else Some s

    let parseArgs =
        function
        | [| NonEmptyString input |] -> Ok input
        | _ -> Error "Usage: please provide a string"

    let handleResult =
        function
        | Ok result ->
            printfn "%s" result
            0
        | Error msg ->
            eprintfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv |> Helpers.parseArgs |> Result.bind Capitalizer.run |> Helpers.handleResult
