import Foundation

guard CommandLine.arguments.count > 0 else {
    exit(0)
}

let usersString = CommandLine.arguments[0]
let reversedCollection = usersString.reversed()
let reversedString = String(reversedCollection)

print(reversedString)
