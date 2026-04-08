open System

module MaximumArrayRotation =
    let run (arr: int[]) =
        let n = int64 arr.Length

        if n = 0L then
            0L
        else
            let sumAll = Array.sumBy int64 arr
            let r0 = arr |> Array.indexed |> Array.sumBy (fun (i, v) -> int64 i * int64 v)

            seq { 1 .. int n - 1 }
            |> Seq.scan (fun prevSum i -> prevSum + sumAll - n * int64 arr[int n - i]) r0
            |> Seq.max

module Helpers =
    let usage = "Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")"

    let private (|IntArray|_|) (s: string) =
        let parts = s.Split(',', StringSplitOptions.RemoveEmptyEntries)

        let rec parseAll i acc =
            if i = parts.Length then
                List.rev acc |> List.toArray |> Some
            else
                match parts[i] |> _.Trim() |> Int32.TryParse with
                | true, n -> parseAll (i + 1) (n :: acc)
                | false, _ -> None

        if parts.Length = 0 then None else parseAll 0 []

    let parseArgs argv =
        match argv with
        | [| IntArray numbers |] -> Ok(numbers)
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
    argv
    |> Helpers.parseArgs
    |> Result.map MaximumArrayRotation.run
    |> Helpers.handleResult
