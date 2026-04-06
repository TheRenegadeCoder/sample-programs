open System


module BubbleSort =
    let private sort (arr: int array) =
        let result = Array.copy arr
        let mutable lastUnsorted = result.Length - 1
        let mutable swapped = true

        while swapped && lastUnsorted > 0 do
            swapped <- false

            for i = 0 to lastUnsorted - 1 do
                if result.[i] > result.[i + 1] then
                    let tmp = result.[i]
                    result.[i] <- result.[i + 1]
                    result.[i + 1] <- tmp
                    swapped <- true

            lastUnsorted <- lastUnsorted - 1

        result

    let run (numbers: int array) =
        numbers |> sort |> Array.map string |> String.concat ", " |> Ok


module Helpers =
    let private (|IntList|_|) (s: string) =
        if String.IsNullOrWhiteSpace(s) then
            None
        else
            let parts = s.Split([| ',' |], StringSplitOptions.RemoveEmptyEntries)
            let len = parts.Length

            if len < 2 then
                None
            else
                let numbers = Array.zeroCreate len
                let mutable ok = true

                for i = 0 to len - 1 do
                    match Int32.TryParse(parts.[i].Trim()) with
                    | true, n -> numbers.[i] <- n
                    | _ -> ok <- false

                if ok then Some numbers else None

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
    argv |> Helpers.parseArgs |> Result.bind BubbleSort.run |> Helpers.handleResult
