open System
open System.Collections.Generic

module ActivePatterns =
    /// Pattern to safely parse a single integer from a trimmed string
    let (|Int|_|) (s: string) =
        match Int32.TryParse(s.Trim()) with
        | true, n -> Some n
        | _ -> None

    /// Pattern to parse a comma-separated list into an int array.
    let (|IntList|_|) (s: string) =
        if String.IsNullOrWhiteSpace s then
            None
        else
            let parts = s.Split(',', StringSplitOptions.RemoveEmptyEntries)
            let parsed = Array.zeroCreate parts.Length
            let mutable allValid = true
            let mutable i = 0

            while allValid && i < parts.Length do
                match parts.[i] with
                | Int x ->
                    parsed.[i] <- x
                    i <- i + 1
                | _ -> allValid <- false

            if allValid && parsed.Length > 0 then Some parsed else None

    /// Validates that a 1D array represents a binary square matrix (size *
    /// size) and transforms it into a 2D bool array.
    let (|AdjacencyMatrix|_|) (size: int) (arr: int array) =
        if arr.Length = size * size && Array.forall (fun x -> x = 0 || x = 1) arr then
            Some(Array2D.init size size (fun r c -> arr.[r * size + c] = 1))
        else
            None

module DepthFirstSearch =
    let run (adj: bool[,], vertices: int array, target: int) =
        let n = vertices.Length
        let visited = Array.zeroCreate n
        let stack = Stack<int>()
        stack.Push 0

        let mutable found = false

        while stack.Count > 0 && not found do
            let node = stack.Pop()

            if not visited.[node] then
                if vertices.[node] = target then
                    found <- true
                else
                    visited.[node] <- true

                    for i in n - 1 .. -1 .. 0 do
                        if adj.[node, i] && not visited.[i] then
                            stack.Push i

        Ok found

module Helpers =
    open ActivePatterns

    let usage =
        "Usage: please provide a tree in an adjacency matrix form (\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, "
        + "1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") together with a list of vertex values (\"1, 3, 5, 2, 4\") and "
        + "the integer to find (\"4\")"

    let parseArgs argv =
        match argv with
        | [| m; v; t |] -> Ok(m, v, t)
        | _ -> Error usage

    let validate (mStr, vStr, tStr) =
        match vStr, tStr with
        | IntList vertices, Int target ->
            // Shortcircuit: if the target isn't in the vertex list, why bother
            // traversing the graph?
            let vSet = HashSet<int>(vertices)

            if not (vSet.Contains target) then
                Ok(None)
            else
                match mStr with
                | IntList mat ->
                    match mat with
                    // Ensure the matrix size matches the number of vertices provided
                    | AdjacencyMatrix vertices.Length adj -> Ok(Some(adj, vertices, target))
                    | _ -> Error usage
                | _ -> Error usage
        | _ -> Error usage

    let handleResult =
        function
        | Ok b ->
            printfn "%b" b
            0
        | Error msg ->
            eprintfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Result.bind Helpers.validate
    |> Result.bind (function
        | Some data -> DepthFirstSearch.run data
        | None -> Ok false)
    |> Helpers.handleResult
