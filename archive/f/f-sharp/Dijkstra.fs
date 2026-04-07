open System
open System.Collections.Generic

let usage =
    "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"

module Dijkstra =

    let private search (adj: (int * int) list[]) (src: int) (dst: int) =
        let n = adj.Length
        let dists = Array.create n Int32.MaxValue
        let visited = Array.create n false
        dists.[src] <- 0

        let pq = PriorityQueue<int, int>()
        pq.Enqueue(src, 0)

        while pq.Count > 0 do
            let u = pq.Dequeue()

            if not visited.[u] then
                visited.[u] <- true

                if u <> dst then
                    for v, w in adj.[u] do
                        if not visited.[v] then
                            let alt = dists.[u] + w

                            if alt < dists.[v] then
                                dists.[v] <- alt
                                pq.Enqueue(v, alt)

        match dists.[dst] with
        | Int32.MaxValue -> Error usage
        | x -> Ok(string x)

    let run (adj, src, dst) = search adj src dst

module Helpers =
    let private (|Int|_|) (s: string) =
        match Int32.TryParse(s.Trim()) with
        | true, n -> Some n
        | _ -> None

    let private (|IntList|_|) (s: string) =
        if String.IsNullOrWhiteSpace s then
            None
        else
            let parts =
                s.Split(',', StringSplitOptions.RemoveEmptyEntries) |> Array.map (fun x -> x.Trim())

            let rec parse idx acc =
                if idx = parts.Length then
                    Some(Array.ofList (List.rev acc))
                else
                    match parts.[idx] with
                    | Int x -> parse (idx + 1) (x :: acc)
                    | _ -> None

            parse 0 []

    let private withinBounds x n = x >= 0 && x < n

    let private isValid n (flat: int array) src dst =
        n > 0
        && flat.Length = n * n
        && withinBounds src n
        && withinBounds dst n
        && not (Array.exists ((>) 0) flat) // 0 > x

    let private (|MatrixInput|_|) (args: string array) =
        match args with
        | [| IntList flat; Int src; Int dst |] ->
            let n = int (sqrt (float flat.Length))

            if isValid n flat src dst then
                let adj =
                    Array.init n (fun r ->
                        [
                            for c in 0 .. n - 1 do
                                let w = flat.[r * n + c]

                                if w > 0 then
                                    yield (c, w)
                        ])

                Some(adj, src, dst)
            else
                None
        | _ -> None

    let parseArgs argv =
        match argv with
        | MatrixInput data -> Ok data
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
    argv |> Helpers.parseArgs |> Result.bind Dijkstra.run |> Helpers.handleResult
