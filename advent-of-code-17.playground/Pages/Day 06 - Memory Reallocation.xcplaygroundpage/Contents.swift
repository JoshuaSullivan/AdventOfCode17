//: # Advent of Code
//: ## Day 6: Memory Reallocation
import Foundation

let input: [Int8] = [11,11,13,7,0,15,5,5,4,4,1,1,7,1,15,11]

let solver = MemorySolver(start: input)
// Check the debug area for a print out of where the cycle was detected.
let simpleSteps = solver.solveSimple()

//: [Previous Page](@previous) | [Next Page](@next)
