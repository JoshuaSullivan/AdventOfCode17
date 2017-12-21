import Foundation

public struct SpinlockGenerator {
    public static func numberAfterZero(step:Int, cycles: Int) -> Int {
        var numberAfterZero = 0
        var index = 0
        for cycle in 1...cycles {
            index = ((index + step) % cycle) + 1
            if index == 1 {
                numberAfterZero = cycle
            }
        }
        return numberAfterZero
    }
}
