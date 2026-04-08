open System

[<Struct>]
type Job = { Profit: int; Deadline: int }


module JobSequencing =
    let rec private findAvailable (parent: int array) (x: int) =
        if parent.[x] <> x then
            parent.[x] <- findAvailable parent parent.[x]

        parent.[x]

    let solve (profits, deadlines) =
        let jobs =
            List.map2 (fun p d -> { Profit = p; Deadline = d }) profits deadlines
            |> List.sortByDescending (fun j -> j.Profit)

        if List.isEmpty jobs then
            0
        else
            let maxDeadline = jobs |> List.maxBy (fun j -> j.Deadline) |> _.Deadline
            let slots = Array.init (maxDeadline + 1) id

            jobs
            |> List.fold
                (fun total job ->
                    let slot = findAvailable slots (min job.Deadline maxDeadline)

                    if slot > 0 then
                        slots.[slot] <- findAvailable slots (slot - 1)
                        total + job.Profit
                    else
                        total)
                0

module Helpers =
    let usage = "Usage: please provide a list of profits and a list of deadlines"

    let private (|IntList|_|) (s: string) =
        s.Split(',', StringSplitOptions.RemoveEmptyEntries)
        |> Array.choose (fun p ->
            match p.Trim() |> Int32.TryParse with
            | true, n -> Some n
            | _ -> None)
        |> fun arr -> if arr.Length > 0 then Some(Array.toList arr) else None

    let parseArgs argv =
        match argv with
        | [| IntList p; IntList d |] when p.Length = d.Length -> Ok(p, d)
        | _ -> Error usage

    let handleResults =
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
    |> Result.map JobSequencing.solve
    |> Helpers.handleResults
