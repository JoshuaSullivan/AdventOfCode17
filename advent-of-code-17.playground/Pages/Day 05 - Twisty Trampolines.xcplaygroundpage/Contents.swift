//: # Advent of Code
//: ## Day 05: A Maze of Twisty Trampolines, All Alike
//: Unlike previous efforts, this one is computationally expensive enough that I'm
//: putting the solver code into the Sources folder so that it has the benefit of
//: being compiled. This makes the code several orders of magnitude faster and
//: prevents Xcode from gobbling up many gigabytes of memory to journal all the
//: program steps.
import Foundation

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let input = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}

var maze = input.split(separator: "\n").flatMap({ Int($0) })
let calc = MazeCalculator(maze: maze)
let simpleSteps = calc.solveMazeSimple()
let complexSteps = calc.solveMazeComplex()

print("Simple escape: \(simpleSteps) steps.")
print("Complex escape: \(complexSteps) steps.")

//: [Previous Page](@previous) | [Next Page](@next)
