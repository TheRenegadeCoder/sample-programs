import Foundation

func error() {
    print("Usage: please provide a string")
}

func duplicateCharacterCounter(string: [String]) {
    if string.isEmpty || string[0].isEmpty {
        error()
    } else {
        let input = string[0]
        var dict = [Character: Int]()

        for char in input{
        dict[char, default: 0] += 1
        }

        var flag = false
        for char in input{
            if let count = dict[char], count > 1 {
                flag = true
                print("\(char): \(count)")
                dict[char] = 0
            }
        }
        if !flag {
            print("No duplicate characters")
        }
    } 
}

let string = CommandLine.arguments.dropFirst().map { String($0) }
duplicateCharacterCounter(string: Array(string))