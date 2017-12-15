//: [Previous](@previous)

import Foundation

var generatorA = NumberGenerator(startingValue: 116, factor: 16807)
var generatorB = NumberGenerator(startingValue: 299, factor: 48271)
//var generatorA = NumberGenerator(startingValue: 65, factor: 16807)
//var generatorB = NumberGenerator(startingValue: 8921, factor: 48271)

let matches = GeneratorSimulator.simulate(genA: generatorA, genB: generatorB, iterations: 40000000)
print("Matches: \(matches)")

//: [Next](@next)
