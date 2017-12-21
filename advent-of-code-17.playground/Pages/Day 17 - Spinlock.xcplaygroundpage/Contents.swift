//: [Previous](@previous)

import Foundation

let input = 312

func createBuffer(stepSize: Int, cycles: Int) -> ([Int], Int) {
    var index = 0
    var buffer = [0]
    for cycle in 1...cycles {
        index = ((index + stepSize) % buffer.count) + 1
        buffer.insert(cycle, at: index)
    }
    return (buffer, index)
}

let result = createBuffer(stepSize: input, cycles: 2017)
print("The value after 2017 is \(result.0[result.1 + 1])")

let numberAfterZero = SpinlockGenerator.numberAfterZero(step:input, cycles: 50_000_000)
print("The number after 0 is \(numberAfterZero)")

//: [Next](@next)
