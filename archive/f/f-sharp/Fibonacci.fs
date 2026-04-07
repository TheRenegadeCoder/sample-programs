open System

module Fibonacci =
    let run n =
        Seq.unfold (fun (a, b) -> Some(a, (b, a + b))) (1, 1)
        |> Seq.take n
        |> Seq.mapi (fun i v -> sprintf "%d: %d" (i + 1) v)
        |> String.concat "\n"

module Helpers =
    let usage = "Usage: please input the count of fibonacci numbers to output"

    let (|NonNegativeInt|_|) (s: string) =
        match s.Trim() |> Int32.TryParse with
        | true, n when n >= 0 -> Some n
        | _ -> None

    let parseArgs argv =
        match argv with
        | [| NonNegativeInt n |] -> Ok n
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
    argv |> Helpers.parseArgs |> Result.map Fibonacci.run |> Helpers.handleResults
