import Foundation

public struct KnotHash {
    
    private var knot: [Int] = []
    private var hash: [Int] = []
    
    public init(lengths: [Int]) {
        knot = createKnot(with: lengths)
        hash = createHash(from: knot)
    }
    
    public init(string: String) {
        var lengths = string.flatMap({ Int($0.unicodeScalars.first(where: { $0.isASCII })!.value) })
        lengths.append(contentsOf:[17, 31, 73, 47, 23])
        knot = createKnot(with: lengths)
        hash = createHash(from: knot)
    }
    
    private func createKnot(with lengths: [Int]) -> [Int] {
        var data = Array(0..<256)
        var skipSize = 0
        var index = 0
        for _ in (0..<64) {
            for length in lengths {
                let workingRange = index..<(index + length)
                data.reverse(range: workingRange)
                index = (index + length + skipSize) % 256
                skipSize += 1
            }
        }
        return data
    }
    
    private func createHash(from knot: [Int]) -> [Int] {
        return stride(from:0, to: 255, by: 16).map({
            index in
            let range = index..<(index + 16)
            return knot[range].reduce(0, { $0 ^ $1 })
        })
    }
    
    public var knotBytes: [Int] {
        return knot
    }
    
    public var hashBytes: [Int] {
        return hash
    }
    
    public var hashString: String {
        return hash.map({
            let a = ($0 & 0xF0) >> 4
            let b = $0 & 0x0F
            return String(a, radix: 16, uppercase: false) + String(b, radix: 16, uppercase: false)
        }).joined()
    }
    
    public var numberOfOnes: Int {
        return hashString.reduce(0, { $0 + $1.numberOfOnes })
    }
}

extension Array {
    subscript(mod index: Int) -> Element {
        get {
            let actualIndex = index % self.count
            return self[actualIndex]
        }
        
        set(newValue) {
            let actualIndex = index % self.count
            self[actualIndex] = newValue
        }
    }
    
    mutating func reverse(range: CountableRange<Int>) {
        var slice: [Element] = []
        for i in range {
            slice.append(self[mod: i])
        }
        for i in range {
            self[mod: i] = slice.popLast()!
        }
    }
}

extension Character {
    var numberOfOnes: Int {
        switch self {
        case "0": return 0
        case "1": return 1
        case "2": return 1
        case "3": return 2
        case "4": return 1
        case "5": return 2
        case "6": return 2
        case "7": return 3
        case "8": return 1
        case "9": return 2
        case "a", "A": return 2
        case "b", "B": return 3
        case "c", "C": return 2
        case "d", "D": return 3
        case "e", "E": return 3
        case "f", "F": return 4
        default: return 0
        }
    }
}
