import Foundation

public struct Scanner: CustomStringConvertible {
    let depth: Int
    let range: Int
    
    public init(string: String) {
        let parts = string.replacingOccurrences(of: ": ", with: ":").split(separator: ":")
        depth = Int(parts[0])!
        range = Int(parts[1])!
    }
    
    func doesDetect(on step: Int) -> Bool {
        let scanIndex = step % ((range - 1) * 2)
        //        print("Scanner at [\(depth)] is scanning \(scanIndex)/\(range)")
        let detected = scanIndex == 0
        //        if detected { print("Detected!") }
        return detected
    }
    
    var severity: Int {
        return depth * range
    }
    
    public var description: String {
        return "Scanner(depth: \(depth), range: \(range))"
    }
}


public class PacketSimulator {
    private let scanners: [Scanner]
    private let maxDepth: Int
    private let scannerMap: [Int : Scanner]
    
    public init(string: String) {
        let scanners = string
            .split(separator: "\n")
            .map({ Scanner(string: String($0)) })
        let maxDepth = scanners.reduce(0, { max($0, $1.depth) })

        self.scanners = scanners
        self.maxDepth = maxDepth
        scannerMap = scanners.reduce(into: [:], { $0[$1.depth] = $1 })
    }
    
    public func calculateSeverity() -> Int {
        var totalSeverity = 0
        for step in (0...maxDepth) {
            guard let scanner = scannerMap[step] else { continue }
            if scanner.doesDetect(on: step) {
                totalSeverity += scanner.severity
            }
        }
        return totalSeverity
    }
    
    public func simulate() -> Int {
        var delay = -1
        var isDetected = false
        repeat {
            isDetected = false
            for step in (0...maxDepth) {
                guard let scanner = scannerMap[step] else { continue }
                if scanner.doesDetect(on: step + delay) {
                    isDetected = true
                    break
                }
            }
            if isDetected { delay += 1 }
        } while isDetected
        return delay
    }
}
