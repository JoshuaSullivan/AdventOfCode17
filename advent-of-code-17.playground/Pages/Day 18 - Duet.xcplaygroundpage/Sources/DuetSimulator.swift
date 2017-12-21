import Foundation

public class DuetSimulator {
    
    private let workers: [Worker]
    private var currentWorker: Int = 0
    private var sendCounts: [Int] = [0, 0]
    private var waiting: [Bool] = [false, false]
    
    public init(commands: [Command]) {
        let w0 = Worker(id: 0, commands: commands)
        let w1 = Worker(id: 1, commands: commands)
        workers = [w0, w1]
    }
    
    public func simulateUntilDeadlock() -> [Int] {
        repeat {
            let result = workers[currentWorker].work()
            switch result {
            case .okay:
                waiting[currentWorker] = false
            case .send(let value):
                let setIndex = currentWorker == 0 ? 1 : 0
                workers[setIndex].inputBuffer.append(value)
                sendCounts[currentWorker] += 1
                waiting = [false, false]
            case .waiting:
                waiting[currentWorker] = true
                currentWorker = currentWorker == 0 ? 1 : 0
            }
        } while !(waiting[0] && waiting[1])
        return sendCounts
    }
}
