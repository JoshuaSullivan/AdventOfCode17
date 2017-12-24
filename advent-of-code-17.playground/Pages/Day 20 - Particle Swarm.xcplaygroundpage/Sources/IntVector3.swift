import Foundation

public struct IntVector3: Hashable, Equatable {
    let x: Int
    let y: Int
    let z: Int
    
    public init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public init(components: [Int]) {
        guard components.count >= 3 else { fatalError("Array was too short.") }
        x = components[0]
        y = components[1]
        z = components[2]
    }
    
    public static func +(lhs: IntVector3, rhs: IntVector3) -> IntVector3 {
        return IntVector3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    
    public var description: String {
        return "<\(x),\(y),\(z)>"
    }
    
    public var magnitude: Float {
        return Float(x * x + y * y + z * z).squareRoot()
    }
    
    public var hashValue: Int {
        return x ^ y ^ z
    }
    
    public static func ==(lhs: IntVector3, rhs: IntVector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

