import Foundation

public class ArrayTwister {
    
    public static func twist(array:[Int], with lengths: [Int]) -> [Int] {
        var skipSize = 0
        var index = 0
        var data = array
        for length in lengths {
            let workingRange = index..<(index + length)
            data.reverse(range: workingRange)
            index = (index + length + skipSize) % 256
            skipSize += 1
        }
        return data
    }
    
    public static func complexTwist(array: [Int], with lengths: [Int], cycles: Int = 64) -> [Int] {
        var skipSize = 0
        var index = 0
        var data = array
        for _ in 0..<cycles {
            for length in lengths {
                let workingRange = index..<(index + length)
                data.reverse(range: workingRange)
                index = (index + length + skipSize) % 256
                skipSize += 1
            }
        }
        return data
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

