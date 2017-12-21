//: [Previous](@previous)

import Foundation

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let rawInput = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}
let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)
let commands = input
    .split(separator: "\n")
    .map({ String($0) })
    .map({ Command(string: $0) })

//: ### Part 1
var index = 0
var registers: [String : Int] = [:]
var didRecover = false
var lastSoundPlayed: Int = 0

func value(for parameter: Command.Parameter) -> Int {
    switch parameter {
    case .value(let value): return value
    case .register(let reg): return registers[reg, default: 0]
    }
}

repeat {
    let command = commands[index]
    switch command {
    case .snd(let reg):
        lastSoundPlayed = registers[reg, default: 0]
    case .set(let reg, let param):
        registers[reg] = value(for: param)
    case .add(let reg, let param):
        registers[reg, default:0] += value(for: param)
    case .mul(let reg, let param):
        registers[reg, default: 0] *= value(for: param)
    case .mod(let reg, let param):
        registers[reg, default: 0] %= value(for: param)
    case .rcv(let reg):
        if registers[reg, default: 0] != 0 {
            didRecover = true
        }
    case .jgz(let param1, let param2):
        let comparitor = value(for: param1)
        if comparitor > 0 {
            index += value(for: param2)
            continue
        }
    }
    index += 1
} while !didRecover

print("Last sound played: \(lastSoundPlayed)")

//: ### Part 2

let testInput = """
snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d
"""
let testCommands = testInput.split(separator: "\n").map({ Command(string: String($0)) })

let simulator = DuetSimulator(commands: commands)
let sendCounts = simulator.simulateUntilDeadlock()
print("Send counts: \(sendCounts)")


//: [Next](@next)
