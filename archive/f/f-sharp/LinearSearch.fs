open System

let (|Int|_|) (s: string) =
    match Int32.TryParse(s.Trim()) with
    | true, n -> Some n
    | _ -> None

let (|IntList|_|) (s: string) =
    if String.IsNullOrWhiteSpace(s) then
        None
    else
        let parts = s.Split([| ',' |], StringSplitOptions.RemoveEmptyEntries)

        let parsed =
            parts
            |> Array.choose (function
                | Int n -> Some n
                | _ -> None)

        if parsed.Length = parts.Length && parsed.Length > 0 then
            Some parsed
        else
            None

module LinearSearch =
    let usage =
        "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"

    let search (target: 'a) (arr: 'a array) =
        let rec loop i =
            if i >= arr.Length then false
            elif arr.[i] = target then true
            else loop (i + 1)

        loop 0

[<EntryPoint>]
let main argv =
    match argv with
    | [| IntList numbers; Int target |] ->
        numbers |> LinearSearch.search target |> string |> _.ToLower() |> printfn "%s"
        0
    | _ ->
        eprintfn "%s" LinearSearch.usage
        1
