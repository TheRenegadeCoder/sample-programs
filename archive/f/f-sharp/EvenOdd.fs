open System

let usage = "Usage: please input a number"

module EvenOdd =
    let run n = if n % 2 = 0 then "Even" else "Odd"

module Helpers =
    let (|Int|_|) (s: string) =
        match s.Trim() |> Int32.TryParse with
        | true, n -> Some n
        | false, _ -> None

    let parseArgs argv =
        match argv with
        | [| Int n |] -> Ok n 
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
    |> Result.map EvenOdd.run
    |> Helpers.handleResults