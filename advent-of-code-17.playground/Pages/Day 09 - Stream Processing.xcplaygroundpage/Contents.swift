//: [Previous](@previous)

import Foundation

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let input = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}

var index = input.startIndex
var groupDepth = 0
var groupScore = 0
var inGarbage = false
var garbageRemoved = 0

repeat {
    let char = input[index]
    switch char {
    case "!": index = input.index(after: index) // Skip the next character
    case "<":
        if !inGarbage {
            inGarbage = true
        } else {
            garbageRemoved += 1
        }
    case ">": inGarbage = false
    case "{":
        if !inGarbage {
            groupDepth += 1
            groupScore += groupDepth
        } else {
            garbageRemoved += 1
        }
    case "}":
        if !inGarbage {
            groupDepth -= 1
        } else {
            garbageRemoved += 1
        }
    default:
        if inGarbage {
            garbageRemoved += 1
        }
    }
    index = input.index(after: index)
} while index != input.endIndex

print("Ending depth: \(groupDepth)")
print("Ending score: \(groupScore)")
print("Garbage characters removed: \(garbageRemoved)")

//: [Next](@next)
