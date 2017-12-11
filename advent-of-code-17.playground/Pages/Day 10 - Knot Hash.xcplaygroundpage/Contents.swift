//: [Previous](@previous)

import Foundation

let input = "157,222,1,2,177,254,0,228,159,140,249,187,255,51,76,30"
let lengths = input.split(separator: ",").map({ Int(String($0))! })

let data = Array(0..<256)

//: ### Part 1

let p1Data = ArrayTwister.twist(array: data, with: lengths)
print("Answer: \(p1Data[0] * p1Data[1])")

//: Part 2
var asciiLengths = input.flatMap({ Int($0.unicodeScalars.first(where: { $0.isASCII })!.value) })
asciiLengths.append(contentsOf: [17, 31, 73, 47, 23])
print("Complex lengths: \(asciiLengths)")
let p2Data = ArrayTwister.complexTwist(array: data, with: asciiLengths)
let xorBytes: [Int] = (0..<16).map({
    let index = $0 * 16
    let range = index..<(index + 16)
    let slice = p2Data[range]
    return slice.reduce(0, { $0 ^ $1 })
})
let byteString: String = xorBytes.map({
    let a = ($0 & 0xF0) >> 4
    let b = $0 & 0x0F
    return String(a, radix: 16, uppercase: false) + String(b, radix: 16, uppercase: false)
}).joined()
print("Complex answer: \(byteString)")
print("Answer length: \(byteString.count)")

//: [Next](@next)
