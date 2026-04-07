module FizzBuzz =
    let (|DivisibleBy|_|) divisor number =
        if number % divisor = 0 then Some() else None

    let fizzBuzzOf number =
        match number with
        | DivisibleBy 3 & DivisibleBy 5 -> "FizzBuzz"
        | DivisibleBy 3 -> "Fizz"
        | DivisibleBy 5 -> "Buzz"
        | _ -> string number

    let printUpTo n =
        Seq.init n (fun i -> i + 1) |> Seq.map fizzBuzzOf |> Seq.iter (printfn "%s")

[<EntryPoint>]
let main _ =
    FizzBuzz.printUpTo 100
    0
