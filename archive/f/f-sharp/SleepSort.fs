open System
open System.Collections.Concurrent

module Sleep =
    let usage =
        "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""

    let (|Int|_|) (s: string) =
        match Int32.TryParse(s.Trim()) with
        | true, n -> Some n
        | _ -> None

    let parse (input: string) =
        input.Split([| ',' |], StringSplitOptions.RemoveEmptyEntries)
        |> Array.choose (function Int n -> Some n | _ -> None)
        |> function
            | arr when arr.Length >= 2 -> Ok arr
            | _ -> Error usage

    let sort (arr: int array) =
        let results = ConcurrentQueue<int>()

        arr
        |> Array.map (fun n ->
            async {
                do! Async.Sleep(n * 1000)
                results.Enqueue(n)
            })
        |> Async.Parallel
        |> Async.RunSynchronously
        |> ignore

        results.ToArray()


[<EntryPoint>]
let main argv =
    let result =
        match argv with
        | [| input |] ->
            input
            |> Sleep.parse
            |> Result.map (Sleep.sort >> Array.map string >> String.concat ", ")
        | _ -> Error Sleep.usage

    match result with
    | Ok output ->
        printfn "%s" output
        0
    | Error msg ->
        printfn "%s" msg
        1
