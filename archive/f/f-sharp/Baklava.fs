let line space asterisk =
    String.replicate space " "  + String.replicate asterisk "*"

let rec baklavaShrink space asterisk =
    if asterisk <= 1 then
        line space 1
    else
        line space asterisk + "\n" + baklavaShrink (space + 1) (asterisk - 2)

let rec baklavaGrow space asterisk =
    if space <= 0 then
        line 0 asterisk + "\n"
    else
        line space asterisk + "\n" + baklavaGrow (space - 1) (asterisk + 2)

let baklava =
    baklavaGrow 10 1 + baklavaShrink 1 19

[<EntryPoint>]
let main argv =
    printfn "%s" <| baklava
    0

