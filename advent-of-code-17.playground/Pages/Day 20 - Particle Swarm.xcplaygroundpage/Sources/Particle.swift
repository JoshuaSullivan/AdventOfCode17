import Foundation

public class Particle: Hashable, Equatable {
    var index: Int
    public var p: IntVector3
    public var v: IntVector3
    public var a: IntVector3
    public var isDestroyed = false
    
    public init(string: String, index: Int) {
        self.index = index
        let pattern = "<[^<>]+?>"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            fatalError("Could not create regular expression.")
        }
        let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
        let angles = CharacterSet(charactersIn: "<>")
        let vectors: [[Int]] = matches
            .map({ (string as NSString).substring(with: $0.range) })
            .map({ $0.trimmingCharacters(in: angles) })
            .map({ $0.split(separator: ",").flatMap({ Int(String($0)) }) })
        p = IntVector3(components: vectors[0])
        v = IntVector3(components: vectors[1])
        a = IntVector3(components: vectors[2])
    }
    
    public func step() {
        v = v + a
        p = p + v
    }
    
    public var quantization: IntVector3 {
        return IntVector3(x: p.x / 10, y: p.y / 10, z: p.z / 10)
    }
    
    public var description: String {
        return "Particle([\(index)] p:\(p.description), v:\(v.description), a:\(a.description))"
    }
    
    public var hashValue: Int {
        return index
    }
    
    public static func ==(lhs: Particle, rhs: Particle) -> Bool {
        return lhs.index == rhs.index
    }
}
