open System

module SelectionSort =
    let rec private selectMin = function
        | [] -> failwith "empty list"
        | [x] -> (x, [])
        | x :: xs ->
            let minRest, rest =
                selectMin xs

            if x <= minRest then
                (x, minRest :: rest)
            else
                (minRest, x :: rest)

    let rec private sort = function
        | [] -> []
        | xs ->
            let min, rest = selectMin xs
            min :: sort rest

    let run numbers =
        numbers |> sort |> List.map string |> String.concat ", " |> Ok

module Result =
    let toOption =
        function
        | Ok x -> Some x
        | Error _ -> None

module Helpers =
    let private (|IntList|_|) (s: string) =
        let ns =
            s.Split(',', StringSplitOptions.RemoveEmptyEntries)
            |> Array.toList
            |> List.map (fun p ->
                match Int32.TryParse(p.Trim()) with
                | true, n -> Ok n
                | false, _ -> Error $"Invalid integer: '{p}'")
            |> List.choose Result.toOption

        if ns.Length >= 2 then Some ns else None

    let parseArgs argv =
        match argv with
        | [| IntList numbers |] -> Ok numbers
        | _ -> Error "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""

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
    |> Result.bind SelectionSort.run
    |> Helpers.handleResult
