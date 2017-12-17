import Foundation

public struct GeneratorSimulator {
    public static func simulate(genA: NumberGenerator, genB: NumberGenerator, iterations: Int) -> Int {
        var zipIterator = zip(genA, genB).makeIterator()
        let range = 0..<iterations
        let mask = 0xFFFF
        return range.reduce(0, {
            count, _ in
            let pair = zipIterator.next()!
            return count + ((pair.0 & mask == pair.1 & mask) ? 1 : 0)
        })
    }

    public static func simulate(genA: PickyNumberGenerator, genB: PickyNumberGenerator, iterations: Int) -> Int {
        var zipIterator = zip(genA, genB).makeIterator()
        let range = 0..<iterations
        let mask = 0xFFFF
        return range.reduce(0, {
            count, _ in
            let pair = zipIterator.next()!
            return count + ((pair.0 & mask == pair.1 & mask) ? 1 : 0)
        })
    }
}
