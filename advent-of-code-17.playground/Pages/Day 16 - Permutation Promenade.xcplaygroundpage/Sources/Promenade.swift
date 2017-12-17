import Foundation

public class Promenade {
    let members: [String]
    let commands: [Command]
    public init(
        members: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"],
        commands: [Command]
    ) {
        self.members = members
        self.commands = commands
    }
    
    public func dance(cycles: Int) -> String {
        var dancers = members
        var history: [String] = [members.joined()]
        for cycle in 0..<cycles {
            for command in commands {
                switch command {
                case .spin(let value):
                    dancers.spin(distance: value)
                case .exchange(let idxA, let idxB):
                    dancers.swapAt(idxA, idxB)
                case .partner(let strA, let strB):
                    let idxA = dancers.index(of: strA)!
                    let idxB = dancers.index(of: strB)!
                    dancers.swapAt(idxA, idxB)
                }
            }
            let result = dancers.joined()
            if let repeatIndex = history.index(of: result) {
                print("Found repeat in cycle \(cycle) of the dance (step \(repeatIndex)).")
//                print(history.joined(separator:"\n"))
//                print("* * * \(result)")
                let offset = cycles % history.count
                print("\(cycles) % \(history.count) = \(offset)")
                return history[offset]
            }
            history.append(result)
        }
        return dancers.joined()
    }
}

extension Array {
    mutating func spin(distance: Int) {
        for _ in 0..<distance {
            let e = self.popLast()!
            self.insert(e, at: 0)
        }
    }
}
