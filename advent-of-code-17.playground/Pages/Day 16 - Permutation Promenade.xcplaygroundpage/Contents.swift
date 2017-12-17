//: [Previous](@previous)

import UIKit

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let rawInput = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}
let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)
let commands = input
    .split(separator: ",")
    .map({ Command(string: String($0)) })
print("Parsed \(commands.count) commands.")

let prom = Promenade(commands: commands)
var result = prom.dance(cycles: 1)
print("Result: \(result)")

let marathonCycles = 1_000_000_000
let marathonResult = prom.dance(cycles: marathonCycles)
print("Marathon result: \(marathonResult)")

//: [Next](@next)
