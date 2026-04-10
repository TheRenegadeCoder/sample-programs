open System

module Matrix =
    let transpose (data: int[,]) =
        let rows = data.GetLength 0
        let cols = data.GetLength 1

        Array2D.init cols rows (fun x y ->
            data.[y, x]
        )

module Helpers =
    let parseInt (s: string) =
        match s.Trim() |> Int32.TryParse with
        | true, v -> Some v
        | _ -> None

    let parseMatrix (s: string) =
        s.Split(',', StringSplitOptions.RemoveEmptyEntries)
        |> Array.choose parseInt
        |> function
            | arr when arr.Length > 0 -> Some arr
            | _ -> None

    let parseArgs (argv: string[]) =
        match argv with
        | [| cStr; rStr; matrixStr |] ->
            match parseInt cStr, parseInt rStr, parseMatrix matrixStr with
            | Some c, Some r, Some values when values.Length = c * r ->
                Ok (c, r, values)

            | _ ->
                Error ()

        | _ ->
            Error ()

    let buildMatrix (c, r, values: int[]) =
        Array2D.init r c (fun i j ->
            values.[i * c + j]
        )

    let handleResult =
        function
        | Ok m ->
            m |> Seq.cast<int> |> Seq.map string |> String.concat ", " |> printfn "%s"
            0

        | Error () ->
            printfn "Usage: please enter the dimension of the matrix and the serialized matrix"
            1


[<EntryPoint>]
let main argv =
    argv
    |> Helpers.parseArgs
    |> Result.map Helpers.buildMatrix
    |> Result.map Matrix.transpose
    |> Helpers.handleResult