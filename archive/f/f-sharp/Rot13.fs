open System

module Rot13 =
    let private rot13Char c =
        let shift baseLetter =
            char (((int c - int baseLetter + 13) % 26) + int baseLetter)

        if c >= 'a' && c <= 'z' then shift 'a'
        elif c >= 'A' && c <= 'Z' then shift 'A'
        else c

    let run = String.map rot13Char

module Helpers =
    let parseArgs =
        function
        | [| s |] when s <> "" -> Ok s
        | _ -> Error "Usage: please provide a string to encrypt"

    let handleResult =
        function
        | Ok s ->
            s |> Rot13.run |> printfn "%s"
            0
        | Error msg ->
            printfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv |> Helpers.parseArgs |> Helpers.handleResult
