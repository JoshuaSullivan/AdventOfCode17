//: [Previous](@previous)

import Foundation

struct Coordinate {
    let x: Int
    let y: Int
    
    static func + (lhs: Coordinate, rhs: Coordinate) -> Coordinate {
        return Coordinate(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func * (lhs: Coordinate, rhs: Int) -> Coordinate {
        return Coordinate(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    var distance: Int {
        let x = abs(self.x)
        let y = abs(self.y)
        if x >= y {
            return x
        } else {
            return x + (y - x) / 2
        }
    }
    
    static let zero = Coordinate(x: 0, y: 0)
}

enum HexDirection: String {
    case n, ne, se, s, sw, nw
    
    var coordinate: Coordinate {
        switch self {
        case .n: return Coordinate(x: 0, y: 2)
        case .ne: return Coordinate(x: 1, y: 1)
        case .se: return Coordinate(x: 1, y: -1)
        case .s: return Coordinate(x: 0, y: -2)
        case .sw: return Coordinate(x: -1, y: -1)
        case .nw: return Coordinate(x: -1, y: 1)
        }
    }
}

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let input = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}
//let input = "se,sw,se,sw,sw"

let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
let allDirections = trimmedInput.split(separator: ",").flatMap({ HexDirection(rawValue: String($0)) })
let finalCoordinate: Coordinate = allDirections.reduce(Coordinate.zero, { $0 + $1.coordinate })
print("Final coordinate: (x: \(finalCoordinate.x), y: \(finalCoordinate.y))")
print("Final distance: \(finalCoordinate.distance)")

var maxDistance = 0
var coordinate = Coordinate.zero
for direction in allDirections {
    coordinate = coordinate + direction.coordinate
    maxDistance = max(maxDistance, coordinate.distance)
}
print("Max distance: \(maxDistance)")

//: [Next](@next)
