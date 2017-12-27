import Foundation

public class Rule {
    private static var ruleCount: Int = 0
    
    var id: Int
    var dim: Int
    var inputs: [[[Bool]]] = []
    let output: [[Bool]]
    
    public init(string: String) {
        self.id = Rule.ruleCount
        Rule.ruleCount += 1
        let components = string
            .replacingOccurrences(of: " => ", with: "@")
            .split(separator: "@")
            .map({String($0)})
        output = components[1].split(separator: "/").map({String($0)}).map({ $0.map({ $0 == "#" }) })
        let baseInput: [[Bool]] = components[0].split(separator: "/").map({String($0)}).map({ $0.map({ $0 == "#" }) })
        dim = baseInput.count
        guard dim == 2 || dim == 3 else { preconditionFailure("What are you even doing?") }
        inputs.append(baseInput)
        if dim == 2 {
            let r0 = rotateClockwise2(array: baseInput)
            let rf0 = flipHorizontal2(array: r0)
            let r1 = rotateClockwise2(array: r0)
            let r2 = rotateClockwise2(array: r1)
            let rf2 = flipHorizontal2(array: r2)
            let v = flipVertical2(array: baseInput)
            let h = flipHorizontal2(array: baseInput)
            inputs.append(contentsOf:[r0, r1, r2, rf0, rf2, v, h])
        } else {
            let r0 = rotateClockwise3(array: baseInput)
            let rf0 = flipHorizontal3(array: r0)
            let r1 = rotateClockwise3(array: r0)
            let r2 = rotateClockwise3(array: r1)
            let rf2 = flipHorizontal3(array: r2)
            let v = flipVertical3(array: baseInput)
            let h = flipHorizontal3(array: baseInput)
            inputs.append(contentsOf:[r0, r1, r2, rf0, rf2, v, h])
        }
    }
    
    func matches(input: [[Bool]]) -> Bool {
        guard input.count == dim else {
            return false
        }
        for pattern in inputs {
            var matches = true
            outerLoop: for y in 0..<dim {
                for x in 0..<dim {
                    guard input[y][x] == pattern[y][x] else {
                        matches = false
                        break outerLoop
                    }
                }
            }
            if matches { return true }
        }
        return false
    }
}

public class Canvas {
    private var area: [[Bool]] = [[false, true, false],[false, false, true], [true, true, true]]
    private let rules: [Rule]
    
    public init(rules: [Rule]) {
        self.rules = rules
    }
    
    public func iterate() {
        let chunks = chunk(array: area)
        let transformed: [[[Bool]]] = chunks.map({
            chunk in
            guard let match = rules.filter({ $0.matches(input:chunk) }).first else {
                fatalError("Chunk matched no rules.")
            }
            return match.output
        })
        area = stitch(chunks: transformed)
    }
    
    private func chunk(array: [[Bool]]) -> [[[Bool]]] {
        let dim: Int
        if array.count % 2 == 0 {
            dim = 2
        } else if array.count % 3 == 0 {
            dim = 3
        } else {
            preconditionFailure("How did the array become non-devisable by 2 or 3?")
        }
        var result: [[[Bool]]] = []
        let chunkCount = array.count / dim
        for cy in 0..<chunkCount {
            for cx in 0..<chunkCount {
                var chunk: [[Bool]] = Array<[Bool]>(repeating: Array<Bool>(repeating: false, count: dim), count: dim)
                for y in 0..<dim {
                    for x in 0..<dim {
                        let ax = cx * dim + x
                        let ay = cy * dim + y
                        chunk[y][x] = array[ay][ax]
                    }
                }
                result.append(chunk)
            }
        }
        return result
    }
    
    private func stitch(chunks: [[[Bool]]]) -> [[Bool]] {
        // Calculate the chunk dimension.
        let dim = Int(Float(chunks.count).squareRoot())
        // Calculate the real dimension.
        let chunkSize = chunks[0].count
        let areaSize = dim * chunkSize
        var canvas = Array<[Bool]>(repeating: Array<Bool>(repeating: false, count: areaSize), count: areaSize)
        for (index, chunk) in chunks.enumerated() {
            let cx = index % dim
            let cy = index / dim
            for y in 0..<chunkSize {
                for x in 0..<chunkSize {
                    canvas[cy * chunkSize + y][cx * chunkSize + x] = chunk[y][x]
                }
            }
        }
        return canvas
    }
    
    public var trueCount: Int {
        let allVals: [Bool] = area.flatMap({$0})
        let allTrues = allVals.filter({ $0 })
        return allTrues.count
    }
}

func rotateClockwise2(array: [[Bool]]) -> [[Bool]] {
    guard array.count == 2 && array[0].count == 2 else {
        preconditionFailure("This method only works on 2x2 arrays.")
    }
    return [[array[1][0], array[0][0]],[array[1][1], array[0][1]]]
}

func rotateClockwise3(array: [[Bool]]) -> [[Bool]] {
    guard array.count == 3 && array[0].count == 3 else {
        preconditionFailure("This method only works on 3x3 arrays.")
    }
    return [[array[2][0], array[1][0], array[0][0]],[array[2][1], array[1][1], array[0][1]],[array[2][2], array[1][2], array[0][2]]]
}

func flipVertical2(array:[[Bool]]) -> [[Bool]] {
    guard array.count == 2 && array[0].count == 2 else {
        preconditionFailure("This method only works on 2x2 arrays.")
    }
    return [[array[1][0], array[1][1]],[array[0][0], array[0][1]]]
}

func flipVertical3(array:[[Bool]]) -> [[Bool]] {
    guard array.count == 3 && array[0].count == 3 else {
        preconditionFailure("This method only works on 3x3 arrays.")
    }
    return [[array[2][0], array[2][1], array[2][2]],[array[1][0], array[1][1], array[1][2]],[array[0][0], array[0][1], array[0][2]]]
}

func flipHorizontal2(array: [[Bool]]) -> [[Bool]] {
    guard array.count == 2 && array[0].count == 2 else {
        preconditionFailure("This method only works on 2x2 arrays.")
    }
    return [[array[0][1], array[0][0]], [array[1][1], array[1][0]]]
}

func flipHorizontal3(array: [[Bool]]) -> [[Bool]] {
    guard array.count == 3 && array[0].count == 3 else {
        preconditionFailure("This method only works on 3x3 arrays.")
    }
    return [[array[0][2], array[0][1], array[0][0]],[array[1][2], array[1][1], array[1][0]],[array[2][2], array[2][1], array[2][0]]]
}
