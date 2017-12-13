import Foundation

public class MemorySolver {
    
    let start: [Int8]
    
    public init(start: [Int8]) {
        self.start = start
    }
    
    public func solveSimple() -> Int {
        var data = start
        var steps = 0
        let count = data.count
        var repeatFound = false
        var history: [[Int8]] = [data]

        repeat {
            let maxIndex = data.maxIndex
            var value = data[maxIndex]
            data[maxIndex] = 0
            var index = (maxIndex + 1) % count
            repeat {
                data[index] += 1
                value -= 1
                index = (index + 1) % count
            } while value > 0
            steps += 1
            if let repeatIndex = contains(list: history, element: data) {
                repeatFound = true
                print("Found repeat at index: \(repeatIndex)")
            }
            history.append(data)
        } while !repeatFound
        return steps
    }
        
    func contains<T: Comparable>(list: [[T]], element: [T]) -> Int? {
        for (index, item) in list.enumerated() {
            if item == element { return index }
        }
        return nil
    }
    
}
