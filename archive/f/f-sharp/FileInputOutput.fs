open System
open System.IO

type FileError =
    | NotFound of string
    | AccessDenied of string
    | IoError of string
    | Unknown of string

    member this.Message =
        match this with
        | NotFound fn -> $"File '{fn}' does not exist."
        | AccessDenied fn -> $"Access denied to file '{fn}'."
        | IoError msg -> $"I/O error occurred: {msg}"
        | Unknown msg -> $"An unexpected error occurred: {msg}"

module FileIO =
    let private toFileError filename (ex: Exception) =
        match ex with
        | :? FileNotFoundException -> NotFound filename
        | :? UnauthorizedAccessException -> AccessDenied filename
        | :? IOException -> IoError ex.Message
        | _ -> Unknown ex.Message

    let private wrapIO filename action =
        try
            action () |> Ok
        with ex ->
            toFileError filename ex |> Error

    let writeTo (filename: string) (contents: string) =
        wrapIO filename (fun () -> File.WriteAllText(filename, contents))

    let readFrom filename =
        wrapIO filename (fun () -> File.ReadLines filename)

let handleResult =
    function
    | Ok() -> 0
    | Error(err: FileError) ->
        eprintfn "%s" err.Message
        1

[<EntryPoint>]
let main _ =
    let filename = "output.txt"

    let contents =
        "I am a string.\n\
         I am also a string.\n\
         F# is fun."

    FileIO.writeTo filename contents
    |> Result.bind (fun () -> FileIO.readFrom filename)
    |> Result.map (Seq.iter (printfn "%s"))
    |> handleResult
