//: [Previous](@previous)

import Foundation

let input = "xlqgujun"
//let input = "flqrgnkx"

//let knot = KnotHash(string: input)
//print(knot.hashString)
//print(knot.numberOfOnes)

let totalOnes = (0..<128).reduce(0, {
    result, rowIndex in
    let knot = KnotHash(string: "\(input)-\(rowIndex)")
    return result + knot.numberOfOnes
})

print("Total ones: \(totalOnes)")

//: [Next](@next)
