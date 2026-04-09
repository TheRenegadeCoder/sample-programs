open System

module Roman =

    let private value =
        function
        | 'I' -> Some 1
        | 'V' -> Some 5
        | 'X' -> Some 10
        | 'L' -> Some 50
        | 'C' -> Some 100
        | 'D' -> Some 500
        | 'M' -> Some 1000
        | _ -> None

    let parse (chars: char[]) =
        let rec loop i acc =
            if i >= chars.Length then acc
            else
                match value chars[i] with
                | None -> acc // unreachable
                | Some v ->
                    if i + 1 < chars.Length then
                        match value chars[i + 1] with
                        | Some v2 when v < v2 ->
                            loop (i + 2) (acc + v2 - v)
                        | _ ->
                            loop (i + 1) (acc + v)
                    else
                        loop (i + 1) (acc + v)

        loop 0 0


module Helpers =

    let private isRomanChar c =
        match c with
        | 'I' | 'V' | 'X' | 'L' | 'C' | 'D' | 'M' -> true
        | _ -> false

    let parseArgs = function
        | [| s |] when s = "" -> Ok [||]
        | [| s |] when s |> Seq.forall isRomanChar -> Ok (s.ToCharArray())
        | [| _ |] -> Error "Error: invalid string of roman numerals"
        | _ -> Error "Usage: please provide a string of roman numerals"

    let handleResult =
        function
        | Ok chars ->
            Roman.parse chars |> printfn "%d"
            0
        | Error msg ->
            printfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Helpers.handleResult