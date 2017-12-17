import Foundation

public protocol NumberGeneratorProtocol: Sequence {
    mutating func next() -> Int
}

public struct NumberGenerator: Sequence, IteratorProtocol {
    public typealias Element = Int
    
    private static let modulus: Int = 2147483647
    
    var value: Int
    var factor: Int
    
    public init(startingValue: Int, factor: Int) {
        value = startingValue
        self.factor = factor
    }
    
    public mutating func next() -> NumberGenerator.Element? {
        value = (value * factor) % NumberGenerator.modulus
        return value
    }
}

public struct PickyNumberGenerator: Sequence, IteratorProtocol {
    public typealias Element = Int
    
    private static let modulus: Int = 2147483647
    
    var value: Int
    var factor: Int
    var pickyMod: Int
    
    public init(startingValue: Int, factor: Int, pickyMod: Int) {
        value = startingValue
        self.factor = factor
        self.pickyMod = pickyMod
    }
    
    public mutating func next() -> PickyNumberGenerator.Element? {
        var nextValue = value
        repeat {
            nextValue = (nextValue * factor) % PickyNumberGenerator.modulus
        } while !(nextValue % pickyMod == 0)
        value = nextValue
        return value
    }
}
