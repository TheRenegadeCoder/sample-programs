open System

let removeAllWhitespace (input: string) : string =
    input |> Seq.filter (fun c -> not (Char.IsWhiteSpace(c))) |> String.Concat

[<EntryPoint>]
let main argv : int = 
    let ret = ref 0  

    if argv.Length = 0 then

        printfn "Usage: please provide a string"
        ret := 1
    else
        let input = argv.[0]
        if input = "" then
           
            printfn "Usage: please provide a string"
            ret := 1
        else
            let result = removeAllWhitespace input
            printfn "%s" result  

    !ret  