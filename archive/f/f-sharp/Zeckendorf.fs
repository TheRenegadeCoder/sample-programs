open System

module Zeckendorf =
    let fibsUpTo n =
        let rec build acc a b =
            if a > n then acc else build (a :: acc) b (a + b)

        build [] 1 2 |> List.toArray

    let run n =
        if n = 0 then
            ""
        else
            let fibs = fibsUpTo n

            Array.foldBack
                (fun f (remaining, acc) ->
                    if f <= remaining then
                        (remaining - f, f :: acc)
                    else
                        (remaining, acc))
                fibs
                (n, [])
            |> snd
            |> List.map string
            |> String.concat ", "

module Helpers =
    let usage = "Usage: please input a non-negative integer"

    let (|NonNegativeInt|_|) (s: string) =
        match s.Trim() |> Int32.TryParse with
        | true, n when n >= 0 -> Some n
        | _ -> None

    let parseArgs =
        function
        | [| NonNegativeInt n |] -> Ok n
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
    argv |> Helpers.parseArgs |> Result.map Zeckendorf.run |> Helpers.handleResult
