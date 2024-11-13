open System

let removeAllWhitespace (input: string) : string =
    input |> Seq.filter (fun c -> not (Char.IsWhiteSpace(c))) |> String.Concat

[<EntryPoint>]
let main argv : int = 
    let ret = ref 0

    if argv.Length > 0 then
        let input = argv.[0]
        
        if  input = "" then 
            ret := 1
        else
            let result = removeAllWhitespace input      
            printfn "%s" result    
    else
        ret := 1
    !ret