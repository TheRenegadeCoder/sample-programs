open System
open System.Text

let usage = "Usage: please provide a mode (encode|decode) and a string"

module Base64 =
    let private (|Encode|Decode|InvalidMode|) (s: string) =
        match s.Trim().ToLowerInvariant() with
        | "encode" -> Encode
        | "decode" -> Decode
        | _ -> InvalidMode

    let private (|NonEmpty|Empty|) (s: string) =
        if String.IsNullOrWhiteSpace s then Empty else NonEmpty s

    let encode =
        function
        | NonEmpty s -> s |> Encoding.UTF8.GetBytes |> Convert.ToBase64String |> Ok
        | Empty -> Error usage

    let decode =
        function
        | NonEmpty s ->
            try
                Convert.FromBase64String s |> Encoding.UTF8.GetString |> Ok
            with _ ->
                Error usage
        | Empty -> Error usage

    let choose =
        function
        | Encode -> Ok encode
        | Decode -> Ok decode
        | InvalidMode -> Error usage

    let run (mode, input) = choose mode |> Result.bind (fun f -> f input)

module Helpers =
    let parseArgs argv =
        match argv with
        | [| mode; input |] -> Ok (mode, input)
        | _ -> Error usage

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
    argv
    |> Helpers.parseArgs
    |> Result.bind Base64.run
    |> Helpers.handleResult
