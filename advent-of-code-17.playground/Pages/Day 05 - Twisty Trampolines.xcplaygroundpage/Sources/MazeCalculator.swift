import Foundation

public class MazeCalculator {
    let maze: [Int]
    
    public init(maze: [Int]) {
        self.maze = maze
    }
    
    public func solveMazeSimple() -> Int {
        var stepCount = 0
        var index = 0
        let mazeBounds = 0..<maze.count
        var mazeCopy = maze
        repeat {
            let step = mazeCopy[index]
            mazeCopy[index] += 1
            index += step
            stepCount += 1
        } while mazeBounds.contains(index)
        return stepCount
    }
    
    public func solveMazeComplex() -> Int {
        var stepCount = 0
        var index = 0
        let mazeBounds = 0..<maze.count
        var mazeCopy = maze
        repeat {
            let step = mazeCopy[index]
            mazeCopy[index] += (step >= 3) ? -1 : 1
            index += step
            stepCount += 1
        } while mazeBounds.contains(index)
        return stepCount
    }
}
