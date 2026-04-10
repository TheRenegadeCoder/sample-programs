open System

module Zeckendorf =

    let fibsDownTo n =
        let rec loop a b acc =
            if a > n then acc
            else loop b (a + b) (a :: acc)

        loop 1 2 []

    let run n =
        if n = 0 then ""
        else
            let rec greedy remaining fibs acc =
                match fibs with
                | [] -> acc
                | f :: fs ->
                    if f <= remaining then
                        greedy (remaining - f) fs (f :: acc)
                    else
                        greedy remaining fs acc

            fibsDownTo n
            |> greedy n []
            |> List.rev
            |> List.map string
            |> String.concat ", "

module Helpers =

    let usage = "Usage: please input a non-negative integer"

    let (|NonNegativeInt|_|) (s: string) =
        match Int32.TryParse(s.Trim()) with
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
    argv
    |> Helpers.parseArgs
    |> Result.map Zeckendorf.run
    |> Helpers.handleResult