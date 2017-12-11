//: [Previous](@previous)

import Foundation

struct Instruction {
    
    enum Comparitor: String {
        case lessThan = "<"
        case greaterThan = ">"
        case lessThanOrEqualTo = "<="
        case greaterThanOrEqualTo = ">="
        case equal = "=="
        case notEqual = "!="
        
        func test(rhs: Int, lhs: Int) -> Bool {
            switch self {
            case .lessThan: return rhs < lhs
            case .greaterThan: return rhs > lhs
            case .lessThanOrEqualTo: return rhs <= lhs
            case .greaterThanOrEqualTo: return rhs >= lhs
            case .equal: return rhs == lhs
            case .notEqual: return rhs != lhs
            }
        }
    }
    
    let targetRegister: String
    let change: Int
    let testRegister: String
    let comparitor: Comparitor
    let testValue: Int
    
    init(string: String) {
        let parts = string.split(separator:" ")
        self.targetRegister = String(parts[0])
        let multiplier = parts[1] == "inc" ? 1 : -1
        self.change = Int(parts[2])! * multiplier
        self.testRegister = String(parts[4])
        self.comparitor = Comparitor(rawValue: String(parts[5]))!
        self.testValue = Int(parts[6])!
    }
}

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let input = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}

let rawInstructions = input.split(separator: "\n").map({ String($0) })
let instructions: [Instruction] = rawInstructions.map({ return Instruction(string: $0) })
var registers: [String : Int] = [:]

var largestRegisterValue = -1

for instruction in instructions {
    let testRegValue = registers[instruction.testRegister, default: 0]
    let testResult = instruction.comparitor.test(rhs: testRegValue, lhs: instruction.testValue)
    if testResult {
        let newValue = registers[instruction.targetRegister, default: 0] + instruction.change
        largestRegisterValue = max(newValue, largestRegisterValue)
        registers[instruction.targetRegister] = newValue
    }
}

let largestFinalValue = registers.values.sorted().last!
print("Largest final register value: \(largestFinalValue)")
print("Largest momentary value: \(largestRegisterValue)")

//: [Next](@next)
