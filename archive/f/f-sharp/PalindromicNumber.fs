open System

module Palindrome =
    let isPalindrome (n: int) =
        if n < 0 then
            false
        elif n % 10 = 0 && n <> 0 then
            false
        else
            let rec loop x rev =
                if x <= rev then
                    x = rev || x = rev / 10
                else
                    loop (x / 10) (rev * 10 + x % 10)

            loop n 0

module Helpers =
    let parseArgs =
        function
        | [| input: string |] ->
            match Int32.TryParse input with
            | true, n when n >= 0 -> Ok n
            | _ -> Error "Usage: please input a non-negative integer"
        | _ -> Error "Usage: please input a non-negative integer"

    let handleResult =
        function
        | Ok result ->
            printfn "%b" result
            0
        | Error msg ->
            eprintfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Result.map Palindrome.isPalindrome
    |> Helpers.handleResult
