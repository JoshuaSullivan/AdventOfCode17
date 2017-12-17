import Foundation

public enum Command {
    case spin(Int)
    case exchange(Int, Int)
    case partner(String, String)
    
    public init(string: String) {
        let code = string.first!
        let details = String(string.dropFirst())
        switch code {
        case "s":
            let count = Int(details)!
            self = .spin(count)
        case "x":
            let parts = details.split(separator: "/").map({ String($0) })
            self = .exchange(Int(parts.first!)!, Int(parts.last!)!)
        case "p":
            self = .partner(String(details.first!), String(details.last!))
        default:
            fatalError("Unexpected command code encountered: \(code)")
        }
    }
}

