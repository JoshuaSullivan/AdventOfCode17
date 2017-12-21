import Foundation

class Worker {
    
    public enum WorkResult {
        case okay
        case send(Int)
        case waiting
    }
    
    let id: Int
    var inputBuffer: [Int] = []
    private let commands: [Command]
    private var registers: [String : Int] = [:]
    private var index = 0
    
    init(id: Int, commands: [Command]) {
        self.id = id
        self.commands = commands
        self.registers["p"] = id
    }
    
    func work() -> WorkResult {
        let command = commands[index]
//        print("[\(id)] \(command.description)")
        switch command {
        case .set(let reg, let param):
            registers[reg] = value(for: param)
        case .add(let reg, let param):
            registers[reg, default:0] += value(for: param)
        case .mul(let reg, let param):
            registers[reg, default: 0] *= value(for: param)
        case .mod(let reg, let param):
            registers[reg, default: 0] %= value(for: param)
        case .snd(let reg):
            index += 1
            return .send(registers[reg, default: 0])
        case .rcv(let reg):
            guard !inputBuffer.isEmpty else {
                return .waiting
            }
            let value = inputBuffer[0]
            inputBuffer.removeFirst()
            registers[reg] = value
        case .jgz(let param1, let param2):
            let comparitor = value(for: param1)
            if comparitor > 0 {
                index += value(for: param2)
                return .okay
            }
        }
        index += 1
        return .okay
    }
    
    func value(for parameter: Command.Parameter) -> Int {
        switch parameter {
        case .value(let value): return value
        case .register(let reg): return registers[reg, default: 0]
        }
    }
}
