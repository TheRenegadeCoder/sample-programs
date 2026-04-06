open System

let removeAllWhitespace = String.filter (Char.IsWhiteSpace >> not)

[<EntryPoint>]
let main argv =
    match argv with
    | [| input |] when not (String.IsNullOrEmpty input) ->
        input |> removeAllWhitespace |> printfn "%s"
        0
    | _ ->
        printfn "Usage: please provide a string"
        1
