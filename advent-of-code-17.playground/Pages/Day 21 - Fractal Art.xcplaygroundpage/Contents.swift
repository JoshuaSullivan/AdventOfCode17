//: [Previous](@previous)

import Foundation


guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let rawInput = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}
let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)
let rules = input
    .split(separator: "\n")
    .map({ String($0) })
    .map({ Rule(string: $0) })

let canvas = Canvas(rules: rules)
for _ in 0..<5 {
    canvas.iterate()
}
print("Final true count: \(canvas.trueCount)")


let canvasTwo = Canvas(rules: rules)
for _ in 0..<18 {
    canvasTwo.iterate()
}
print("After 18 iterations: \(canvasTwo.trueCount)")
//: [Next](@next)
