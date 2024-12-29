module Main

repeatString : String -> Int -> String
repeatString s n = if n < 1 then "" else s ++ repeatString s (n - 1)

baklavaLine : Int -> String
baklavaLine n = repeatString " " numSpaces ++ repeatString "*" numStars
    where
        numSpaces = abs n
        numStars = 21 - 2 * numSpaces

main : IO ()
main = sequence_ $ map (putStrLn . baklavaLine) [-10..10]
