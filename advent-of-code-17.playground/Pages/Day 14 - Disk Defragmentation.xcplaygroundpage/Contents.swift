//: [Previous](@previous)

import Foundation

let input = "xlqgujun"
//let input = "flqrgnkx"

let range = 0..<128
let knots = range.map({ KnotHash(string: "\(input)-\($0)") })
let totalOnes = knots.reduce(0, { $0 + $1.numberOfOnes })
print("Total ones: \(totalOnes)")

let bitField = BitField(knots: knots)
print(bitField.visualMap)
var regions = bitField.findRegions()
print("Regions: \(regions)")

//: [Next](@next)
