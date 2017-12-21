import Foundation

public enum Command {
    
    public enum Parameter {
        case value(Int)
        case register(String)
        
        public init(string: String) {
            if let val = Int(string) {
                self = .value(val)
            } else {
                self = .register(string)
            }
        }
        
        public var description: String {
            switch self {
            case .value(let val): return "\(val)"
            case .register(let reg): return reg
            }
        }
    }
    
    case snd(String)
    case rcv(String)
    case set(String, Parameter)
    case add(String, Parameter)
    case mul(String, Parameter)
    case mod(String, Parameter)
    case jgz(Parameter, Parameter)
    
    public init(string: String) {
        let parts = string.split(separator: " ").map({String($0)})
        switch parts[0] {
        case "snd": self = .snd(parts[1])
        case "rcv": self = .rcv(parts[1])
        case "set": self = .set(parts[1], Parameter(string: parts[2]))
        case "add": self = .add(parts[1], Parameter(string: parts[2]))
        case "mul": self = .mul(parts[1], Parameter(string: parts[2]))
        case "mod": self = .mod(parts[1], Parameter(string: parts[2]))
        case "jgz": self = .jgz(Parameter(string: parts[1]), Parameter(string: parts[2]))
        default:
            fatalError("Unrecognized command: \(parts[0])")
        }
    }
    
    public var description: String {
        switch self {
        case .snd(let reg): return "snd \(reg)"
        case .rcv(let reg): return "rcv \(reg)"
        case .set(let reg, let param): return "set \(reg) \(param.description)"
        case .add(let reg, let param): return "add \(reg) \(param.description)"
        case .mul(let reg, let param): return "mul \(reg) \(param.description)"
        case .mod(let reg, let param): return "mod \(reg) \(param.description)"
        case .jgz(let param1, let param2): return "jgz \(param1.description) \(param2.description)"
        }
    }
}
