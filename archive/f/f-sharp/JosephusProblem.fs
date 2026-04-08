open System

module Josephus =
    let run (n, k) =
        if n = 1 then
            Ok 1
        elif k = 1 then
            Ok n
        elif k = 2 then
            // fast formula for k = 2
            let mutable p = 1

            while p <= n do
                p <- p <<< 1

            Ok(2 * (n - (p >>> 1)) + 1)
        else
            // general k > 2 using iterative approach
            let mutable survivor = 0

            for i in 2..n do
                survivor <- (survivor + k) % i

            Ok(survivor + 1)

module Helpers =
    let usage =
        "Usage: please input the total number of people and number of people to skip."

    let private (|Int|_|) (s: string) =
        match s.Trim() |> Int32.TryParse with
        | true, n -> Some n
        | false, _ -> None

    let parseArgs argv =
        match argv with
        | [| Int n; Int k |] when n > 0 && k > 0 -> Ok(n, k)
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
    argv |> Helpers.parseArgs |> Result.bind Josephus.run |> Helpers.handleResult
