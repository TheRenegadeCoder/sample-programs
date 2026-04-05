open System

module Josephus =
    let usage =
        "Usage: please input the total number of people and number of people to skip."

    let findSurvivor n k =
        let rec loop m result =
            if m > n then
                result + 1
            else
                loop (m + 1) ((result + k) % m)

        loop 2 0

[<EntryPoint>]
let main argv =
    match argv with
    | [| nStr; kStr |] ->
        match Int32.TryParse nStr, Int32.TryParse kStr with
        | (true, n), (true, k) when n > 0 && k > 0 ->
            Josephus.findSurvivor n k |> printfn "%d"
            0
        | _ ->
            printfn "%s" Josephus.usage
            1
    | _ ->
        printfn "%s" Josephus.usage
        1
