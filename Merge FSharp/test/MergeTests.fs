module MergeTests

[<Tests>]
let tests =
    testList "Merge Tests" [
        testCase "Merge two sorted lists" <| fun _ ->
            let result = merge [1;3;5] [2;4;6]
            Expect.equal result [1;2;3;4;5;6] "Should merge sorted lists"

        testCase "Merge with empty list" <| fun _ ->
            let result = merge [] [2;4;6]
            Expect.equal result [2;4;6] "Should handle empty first list"
    ]