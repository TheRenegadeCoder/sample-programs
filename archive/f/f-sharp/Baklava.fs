open System

let inline repeat count (char: char) = String(char, count)

let baklava size =
    { -size .. size }
    |> Seq.map (fun y ->
        let padding = abs y
        repeat padding ' ' + repeat (2 * (size - padding) + 1) '*')
    |> String.concat Environment.NewLine

[<EntryPoint>]
let main argv =
    baklava 10 |> printfn "%s"
    0
