//: [Previous](@previous)

import Foundation

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let rawInput = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}
let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)

let sim = PacketSimulator(string: input)

print("Total severity: \(sim.calculateSeverity())")

let delay = sim.simulate()
print("delay: \(delay)")


//: [Next](@next)
