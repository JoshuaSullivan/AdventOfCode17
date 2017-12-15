import Foundation

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
