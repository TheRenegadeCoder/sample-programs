open System

let removeAllWhitespace (input: string) : string =
    input |> Seq.filter (fun c -> not (Char.IsWhiteSpace(c))) |> String.Concat

[<EntryPoint>]
let main argv : int = 
    let ret = ref 0
    if argv.Length > 0 then
        let input = argv.[0]
        printfn "Input: %s" input
        if  input = "" then
            printfn "Usage: please provide a string" 
            ret :=1
        else
            let result = removeAllWhitespace input      
            printfn "Result: %s" result
            
    else
          printfn "Usage: please provide a string" 
          ret :=1
    !ret