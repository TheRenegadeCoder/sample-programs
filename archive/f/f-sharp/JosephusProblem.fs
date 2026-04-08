open System

module Josephus =
    let private largestPowerOf2 n =
        // 1 <<< (31 - BitOperations.LeadingZeroCount(uint32 n))
        let mutable p = 1

        while p <= n do
            p <- p <<< 1

        p >>> 1

    let rec private josephusGeneral n k =
        let cnt = n / k
        let res = josephusGeneral (n - cnt) k
        let res = res - (n % k)
        if res < 0 then res + n else res + (res / (k - 1))

    let run (n, k) =
        let survivor =
            if   n = 1 then 1              // only one person
            elif k = 1 then n              // remove 1 by 1, last survives
            elif k = 2 then                // fast formula for k = 2
                let p = largestPowerOf2 n
                2 * (n - p) + 1
            else
                1 + josephusGeneral n k    // general k > 2

        Ok survivor 

module Helpers =
    let usage =
        "Usage: please input the total number of people and number of people to skip."

    let private (|Int|_|) (s: string) =
        match s.Trim() |> Int32.TryParse with
        | true, n -> Some n
        | false, _ -> None

    let parseArgs argv =
        match argv with
        | [| Int n; Int k |] when n > 0 && k > 0 -> Ok(n, k)
        | _ -> Error usage

    let handleResult =
        function
        | Ok result ->
            printfn "%d" result
            0
        | Error msg ->
            eprintfn "%s" msg
            1

[<EntryPoint>]
let main argv =
    argv |> Helpers.parseArgs |> Result.bind Josephus.run |> Helpers.handleResult
