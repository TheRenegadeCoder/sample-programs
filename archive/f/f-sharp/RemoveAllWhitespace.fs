open System

let removeAllWhitespace (input: string) : string =
    input |> Seq.filter (fun c -> not (Char.IsWhiteSpace(c))) |> String.Concat

[<EntryPoint>]
let main argv =
    if argv.Length > 0 then
        let input = argv.[0]
        
        if  input = "" then
            printfn "Usage: please provide a string"
        else
            let result = removeAllWhitespace input      
            printfn "%s" result
    else
        printfn "Usage: please provide a string"
    
