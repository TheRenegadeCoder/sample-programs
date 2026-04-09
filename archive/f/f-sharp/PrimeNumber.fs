open System

module Prime =
    let isPrime n =
        if n < 2 then false
        elif n = 2 then true
        elif n % 2 = 0 then false
        else
            let rec loop d =
                if d * d > n then true
                elif n % d = 0 then false
                else loop (d + 2)
            loop 3

module Helpers =
    let parseArgs =
        function
        | [| input: string |] ->
            match Int32.TryParse input with
            | true, n when n >= 0 -> Ok n
            | _ -> Error "Usage: please input a non-negative integer"
        | _ -> Error "Usage: please input a non-negative integer"

    let handleResult = function
        | Ok true  -> printfn "prime"; 0
        | Ok false -> printfn "composite"; 0
        | Error e  -> eprintfn "%s" e; 1

[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Result.map Prime.isPrime
    |> Helpers.handleResult
