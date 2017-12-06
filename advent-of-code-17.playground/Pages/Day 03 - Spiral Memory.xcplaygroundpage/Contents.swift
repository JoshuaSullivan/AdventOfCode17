//: # Advent of Code
//: ## Day 03: Spiral Memory
import Swift

let input = 277678

// Calculate the size of the spiral needed to contain the value in question.
// Spiral dimensions are always odd.
var spiralDim = Int(ceil(sqrt(Float(input))))
if spiralDim % 2 == 0 { spiralDim += 1 }

// Calculate the entry index of the spiral
let entryIndex = max(0, (spiralDim - 2) * (spiralDim - 2))

// The distance around the spiral from the entry index to the input value.
let indexDistance = input - entryIndex


//: [Previous Page](@previous) | [Next Page](@next)
