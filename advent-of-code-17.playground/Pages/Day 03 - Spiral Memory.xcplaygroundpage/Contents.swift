//: # Advent of Code
//: ## Day 03: Spiral Memory
import Swift

let input = 277678

struct SpiralArrayGeometry: CustomStringConvertible {
    
    let dimension: Int
    let ringOrder: Int
    let featureInterval: Int
    let entryIndex: Int
    
    init(value: Int) {
        let dim = Int(Float(value).squareRoot().rounded(.up))
        dimension = (dim % 2 == 0) ? dim + 1 : dim
        ringOrder = (dimension - 1) / 2
        featureInterval = ringOrder * 2
        let lowerDim = max(0, dimension - 2)
        entryIndex = lowerDim * lowerDim
    }
    
    var description: String {
        return "SpiralArrayGeometry(dimension: \(dimension), ringOrder: \(ringOrder), featureInterval: \(featureInterval) entryIndex: \(entryIndex))"
    }
}

// Calculate the size of the spiral needed to contain the value in question.
// Spiral dimensions are always odd.

let geometry = SpiralArrayGeometry(value: input)

let cardinals = (0...3).map({ geometry.entryIndex + $0 * geometry.featureInterval + geometry.ringOrder})
let cardinalDistances = cardinals.map({ Int(($0 - input).magnitude) }).sorted()
let travelDistance = geometry.ringOrder + cardinalDistances[0]
print("Distance traveled: \(travelDistance)")

//: ### Part 2

struct ArrayCoordinate: CustomStringConvertible {
    let x: Int
    let y: Int
    
    static func + (lhs: ArrayCoordinate, rhs: ArrayCoordinate) -> ArrayCoordinate {
        return ArrayCoordinate(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    var description: String {
        return "[x: \(x), y: \(y)]"
    }
}

var spiralRow = Array<Int>(repeating: 0, count: geometry.dimension)
var spiralArray = Array<Array<Int>>(repeating: spiralRow, count: geometry.dimension)
let centerIndex = geometry.dimension - geometry.ringOrder
let center = ArrayCoordinate(x: centerIndex, y: centerIndex)
let up = ArrayCoordinate(x: 0, y: -1)
let down = ArrayCoordinate(x: 0, y: 1)
let right = ArrayCoordinate(x: 1, y: 0)
let left = ArrayCoordinate(x: -1, y: 0)

var currentPosition = center

func getValue<T>(of array: [[T]], at coordinate: ArrayCoordinate) -> T {
    return array[coordinate.x][coordinate.y]
}

func sum(for array: [[Int]], at position: ArrayCoordinate) -> Int {
    let range = [-1, 0, 1]
    var sum = 0
    for dx in range {
        for dy in range {
            let offset = ArrayCoordinate(x: dx, y: dy)
            sum += getValue(of: array, at: position + offset)
        }
    }
    return sum
}

func findNextCoordinate(from coordinate: ArrayCoordinate, index: Int) -> ArrayCoordinate {
    let geometry = SpiralArrayGeometry(value: index)
    print(geometry)
    let distance = index - geometry.entryIndex
    let fi = geometry.featureInterval
    if distance < fi { return coordinate + up }
    else if distance < 2 * fi { return coordinate + left }
    else if distance < 3 * fi { return coordinate + down }
    else { return coordinate + right }
}

var index = 1
var value = 0
repeat {
    value = max(1, sum(for: spiralArray, at: currentPosition))
    print("\(index): \(currentPosition) = \(value)")
    spiralArray[currentPosition.x][currentPosition.y] = value
    currentPosition = findNextCoordinate(from: currentPosition, index: index)
    index += 1
} while (value <= input)

//: [Previous Page](@previous) | [Next Page](@next)
