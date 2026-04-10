open System

module Zeckendorf =

    let getDescendingFibs n =
        let rec loop a b acc =
            if a > n then acc
            else loop b (a + b) (a :: acc)
        
        loop 1 2 []

    let compute n =
        if n = 0 then []
        else
            let rec go remaining fibs acc =
                match remaining, fibs with
                | 0, _ -> List.rev acc
                | _, [] -> List.rev acc
                | r, f :: tail ->
                    if f <= r then
                        go (r - f) tail (f :: acc)
                    else
                        go r tail acc

            go n (getDescendingFibs n) []

    let run n =
        match compute n with
        | [] -> ""
        | fibs -> String.concat ", " (List.map string fibs)

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