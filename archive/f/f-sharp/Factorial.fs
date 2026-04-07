open System

module Factorial =
    let rec private factorial n acc =
        if n <= 1L then acc else factorial (n - 1L) (acc * n)

    let run n = factorial n 1L |> string

module Helpers =
    let usage = "Usage: please input a non-negative integer"

    let (|NonNegativeInteger|_|) (s: string) =
        match s.Trim() |> Int64.TryParse with
        | true, n when n >= 0L -> Some n
        | _ -> None

    let parseArgs argv =
        match argv with
        | [| NonNegativeInteger n |] -> Ok n
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
    argv |> Helpers.parseArgs |> Result.map Factorial.run |> Helpers.handleResults
