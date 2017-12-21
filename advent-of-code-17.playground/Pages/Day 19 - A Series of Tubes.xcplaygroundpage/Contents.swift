//: [Previous](@previous)

import Foundation

enum Tile: Equatable {
    case empty
    case vertical
    case horizontal
    case corner
    case letter(Character)
    
    init(char: Character) {
        switch char {
        case " ": self = .empty
        case "|": self = .vertical
        case "-": self = .horizontal
        case "+": self = .corner
        default: self = .letter(char)
        }
    }
    
    var description: Character {
        switch self {
        case .empty: return " "
        case .vertical: return "|"
        case .horizontal: return "-"
        case .corner: return "+"
        case .letter(let char): return char
        }
    }
    
    static func ==(lhs: Tile, rhs: Tile) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty), (.vertical, .vertical), (.horizontal, .horizontal), (.corner, .corner):
            return true
        case (.letter(let char0), .letter(let char1)):
            return char0 == char1
        default:
            return false
        }
    }
}

class MazeRunner {
    
    typealias Neighbors = [Direction : Tile]
    
    enum Direction: String {
        case up
        case down
        case left
        case right
        case finished
        
        var dx: Int {
            switch self {
            case .up, .down, .finished: return 0
            case .left: return -1
            case .right: return 1
            }
        }
        
        var dy: Int {
            switch self {
            case .left, .right, .finished: return 0
            case .up: return -1
            case .down: return 1
            }
        }
    }
    
    let tileMap : [[Tile]]
    init(tileMap: [[Tile]]) {
        self.tileMap = tileMap
    }
    
    func runMaze() -> [Character] {
        var x = 0
        var y = 0
        var stepCount = 0
        for (index, tile) in tileMap[0].enumerated() {
            if tile == .vertical {
                x = index
                break
            }
        }
        var foundChars: [Character] = []
        var lastDirection: Direction = .down
        print("Starting run at \(x), \(y)")
        repeat {
            let tile = tileMap[y][x]
            let n = neighbors(forX: x, y: y)
            if case .letter(let char) = tile {
                print("Found: \(char)")
                foundChars.append(char)
            }
            let next = nextDirection(for: tile, previousDirection: lastDirection, neighbors: n)
            x += next.dx
            y += next.dy
            lastDirection = next
            stepCount += 1
        } while lastDirection != .finished
        print("Completed trip in \(stepCount) steps.")
        return foundChars
    }
    
    private func nextDirection(for tile: Tile, previousDirection: Direction, neighbors: Neighbors) -> Direction {
        switch tile {
        case .horizontal, .vertical, .letter(_):
            if case .empty = neighbors[previousDirection, default: .empty] {
                return .finished
            }
            return previousDirection
        case .corner:
            switch previousDirection {
            case .left, .right:
                if let up = neighbors[.up], up != .empty {
                    return .up
                } else if let down = neighbors[.down], down != .empty {
                    return .down
                } else {
                    fatalError("Could not find way out of corner.")
                }
            case .up, .down:
                if let left = neighbors[.left], left != .empty {
                    return .left
                } else if let right = neighbors[.right], right != .empty {
                    return .right
                } else {
                    fatalError("Could not find way out of corner.")
                }
            case .finished:
                fatalError("Should not be exploring the map after we finish.")
            }
        case .empty:
            return .finished
        }
    }
    
    func neighbors(forX x: Int, y: Int) -> Neighbors {
        var n: Neighbors = [:]
        if (x > 0) {
            n[.left] = tileMap[y][x-1]
        }
        if (x < tileMap[y].count - 1) {
            n[.right] = tileMap[y][x+1]
        }
        if (y > 0) {
            n[.up] = tileMap[y - 1][x]
        }
        if (y < tileMap.count - 1) {
            n[.down] = tileMap[y + 1][x]
        }
        return n
    }
}

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let rawInput = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}
let input = rawInput.trimmingCharacters(in: .newlines)
let tileMap: [[Tile]] = input
    .split(separator: "\n")
    .map({ String($0) })
    .map({ $0.map({ char in Tile(char: char) }) })
print("Map appears to be \(tileMap[0].count) x \(tileMap.count) tiles.")

let runner = MazeRunner(tileMap: tileMap)
let result = runner.runMaze()
print("Result: \(String(result))")

//: [Next](@next)
