open System

module BinarySearch =
    let private search (haystack: int array) (needle: int) =
        let len = haystack.Length

        if needle < haystack.[0] || needle > haystack.[len - 1] then
            false
        else
            let rec loop lo hi =
                if lo > hi then
                    false
                else
                    let mid = lo + (hi - lo) / 2

                    match compare needle haystack.[mid] with
                    | 0 -> true
                    | c when c < 0 -> loop lo (mid - 1)
                    | _ -> loop (mid + 1) hi

            loop 0 (len - 1)

    let find haystack needle = search haystack needle

module Helpers =

    let private isSorted itemList =
        itemList |> Seq.pairwise |> Seq.forall (fun (a, b) -> a <= b)

    let private (|Int|_|) (s: string) =
        match Int32.TryParse(s.Trim()) with
        | true, n -> Some n
        | _ -> None

    let private (|SortedIntList|_|) (s: string) =
        if String.IsNullOrWhiteSpace(s) then
            None
        else
            let parts = s.Split([| ',' |], StringSplitOptions.RemoveEmptyEntries)

            let parsed =
                parts
                |> Array.choose (
                    function
                    | Int n -> Some n
                    | _ -> None
                )

            if not (Array.isEmpty parsed) && parsed.Length = parts.Length && isSorted parsed then
                Some parsed
            else
                None

    let parseArgs argv =
        match argv with
        | [| SortedIntList numbers; Int target |] -> Ok(numbers, target)
        | _ ->
            Error
                "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"

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
    let okBool (b: bool) = if b then Ok "true" else Ok "false"

    argv
    |> Helpers.parseArgs
    |> Result.bind (fun (numbers, target) -> BinarySearch.find numbers target |> okBool)
    |> Helpers.handleResult
