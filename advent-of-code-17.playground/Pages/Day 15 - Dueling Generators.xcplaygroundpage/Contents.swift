//: [Previous](@previous)

import Foundation

var generatorA = NumberGenerator(startingValue: 116, factor: 16807)
var generatorB = NumberGenerator(startingValue: 299, factor: 48271)
//var generatorA = NumberGenerator(startingValue: 65, factor: 16807)
//var generatorB = NumberGenerator(startingValue: 8921, factor: 48271)

let matches = GeneratorSimulator.simulate(genA: generatorA, genB: generatorB, iterations: 40_000_000)
print("Matches: \(matches)")

var pickyA = PickyNumberGenerator(startingValue: 116, factor: 16807, pickyMod: 4)
var pickyB = PickyNumberGenerator(startingValue: 299, factor: 48271, pickyMod: 8)
//var pickyA = PickyNumberGenerator(startingValue: 65, factor: 16807, pickyMod: 4)
//var pickyB = PickyNumberGenerator(startingValue: 8921, factor: 48271, pickyMod: 8)

let pickyMatches = GeneratorSimulator.simulate(genA: pickyA, genB: pickyB, iterations: 5_000_000)
print("Picky matches: \(pickyMatches)")

//: [Next](@next)
