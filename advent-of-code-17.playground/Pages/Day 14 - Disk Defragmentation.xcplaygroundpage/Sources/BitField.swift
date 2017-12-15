import Foundation

public enum FieldBit {
    case empty
    case filled
    case mapped
    
    public var description: String {
        switch self {
        case .empty: return "."
        case .filled: return "+"
        case .mapped: return "#"
        }
    }
}

public class BitField {
    var bitField: [[FieldBit]]
    
    public init(knots: [KnotHash]) {
        bitField = knots.map({ $0.bitField })
    }
    
    public func findRegions() -> Int {
        let range = 0..<128
        var regions = 0
        for x in range {
            for y in range {
                guard bitField[x][y] == .filled else { continue }
                let flooded = floodRegion(in: &bitField, x: x, y: y)
                regions += 1
            }
        }
        return regions
    }
    
    func floodRegion(in bitField: inout [[FieldBit]], x: Int, y: Int) -> Int {
        bitField[x][y] = .mapped
        var flooded = 1
        if x < 127 && bitField[x+1][y] == .filled {
            flooded += floodRegion(in: &bitField, x: x+1, y: y)
        }
        if y < 127 && bitField[x][y+1] == .filled {
            flooded += floodRegion(in: &bitField, x: x, y: y+1)
        }
        if x > 0 && bitField[x-1][y] == .filled {
            flooded += floodRegion(in: &bitField, x: x-1, y: y)
        }
        if y > 0 && bitField[x][y-1] == .filled {
            flooded += floodRegion(in: &bitField, x: x, y: y-1)
        }
        return flooded
    }
    
    public var visualMap: String {
        return bitField.map({ $0.map({ $0.description }).joined(separator:"") }).joined(separator:"\n")
    }

}
