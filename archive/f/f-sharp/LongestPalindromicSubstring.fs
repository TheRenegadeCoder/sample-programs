open System
open System.Text

module LPS =
    let private preprocess (s: string) =
        let sb = StringBuilder("#", s.Length * 2 + 1)
        s |> Seq.iter (fun ch -> sb.Append(ch).Append('#') |> ignore)
        sb.ToString()

    let run (s: string) =
        let t = preprocess s
        let n = t.Length
        let p = Array.zeroCreate n

        let mutable c, r = 0, 0

        for i in 0 .. n - 1 do
            let mirror = 2 * c - i

            if i < r then
                p[i] <- min (r - i) p[mirror]

            let rec expand dist =
                let left, right = i - (dist + 1), i + (dist + 1)

                if left >= 0 && right < n && t[left] = t[right] then
                    expand (dist + 1)
                else
                    dist

            p[i] <- expand p[i]

            if i + p[i] > r then
                c <- i
                r <- i + p[i]

        let mutable maxLen = -1
        let mutable maxCenter = 0

        for i in 0 .. n - 1 do
            if p[i] > maxLen then
                maxLen <- p[i]
                maxCenter <- i

        s.Substring((maxCenter - maxLen) / 2, maxLen)


module Helpers =
    let usage = "Usage: please provide a string that contains at least one palindrome"

    let private containsPalindrome (s: string) =
        if isNull s || s.Length < 2 then false
        else
            // Check for adjacent duplicates (aa) or sandwiched characters (aba)
            let rec check i =
                if i >= s.Length - 1 then false
                // Check for "aa" or "aba" seeds
                elif s[i] = s[i + 1] || (i < s.Length - 2 && s[i] = s[i + 2]) then true
                else check (i + 1)

            check 0

    let parseArgs argv =
        match argv with
        | [| s |] when containsPalindrome s -> Ok s
        | _ -> Error usage

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
    argv |> Helpers.parseArgs |> Result.map LPS.run |> Helpers.handleResult
