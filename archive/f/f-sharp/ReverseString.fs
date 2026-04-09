open System

module Reverse =
    let run (s: string) =
        let arr = s.ToCharArray()
        Array.Reverse arr
        String arr

module Helpers =

    let parseArgs = function
        | [| s |] -> Some s
        | _ -> None

    let handle = function
        | Some s ->
            s |> Reverse.run |> printfn "%s"
        | None ->
            printfn ""

[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Helpers.handle

    0