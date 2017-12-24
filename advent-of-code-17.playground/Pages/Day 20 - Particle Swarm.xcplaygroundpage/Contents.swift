//: [Previous](@previous)

import Foundation

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let rawInput = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}
let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)
let lines = input.split(separator: "\n").map({ String($0) })
let particles = lines.enumerated().map({ Particle(string: $1, index: $0) })
//: ### Part 1
let p1Answer = Simulator.simulateStep1(particles: particles)
print("Least motivated particle: \(p1Answer.description)")

//: ### Part 2

let p2Answer = Simulator.simulateStep2(particles: particles)
print("Remaining particles after 10000 steps: \(p2Answer)")

//: [Next](@next)
