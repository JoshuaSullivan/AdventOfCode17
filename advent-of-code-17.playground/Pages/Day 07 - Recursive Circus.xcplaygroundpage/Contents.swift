
import Foundation

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let input = try? String(contentsOf: inputURL, encoding: .utf8)
else {
    fatalError("Could not find input file.")
}

class Actor: CustomStringConvertible {
    let name: String
    let weight: Int
    var parent: Actor?
    var childNames: [String]
    var children: [Actor] = []
    
    init(name: String, weight: Int, childNames: [String] = []) {
        self.name = name
        self.weight = weight
        self.childNames = childNames
    }
    
    var description: String {
        return "Actor(name: \(name), weight: \(weight), children:\(childNames))"
    }
    
    lazy var totalWeight: Int = {
        return self.weight + self.children.reduce(0, { $0 + $1.totalWeight })
    }()
    
    var shortDescription: String {
        return "[\(name)] weight: \(weight) (\(totalWeight)), children: \(children.count)"
    }
}

let parensSet = CharacterSet(charactersIn: "()")

var actorMap: [String : Actor] = [:]
let actors: [Actor] = input.split(separator: "\n")
    .map({
        let parts = $0.split(separator: " ", maxSplits: 3, omittingEmptySubsequences: true)
        let name = String(parts[0])
        let weight = Int(parts[1].trimmingCharacters(in: parensSet))!
        guard
            parts.count > 2,
            let rawChildren = parts.last
        else {
            let actor = Actor(name: name, weight: weight)
            actorMap[name] = actor
            return actor
        }
        let names = rawChildren
            .split(separator: ",")
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
        let actor = Actor(name: name, weight: weight, childNames: names)
        actorMap[name] = actor
        return actor
    })

let actorsWithChildren: [Actor] = actors.filter({ !$0.childNames.isEmpty })
for actor in actorsWithChildren {
    let children: [Actor] = actor.childNames.flatMap({
        guard let child = actorMap[$0] else { return nil }
        child.parent = actor
        return child
    })
    actor.children = children
}

let parentlessActors = actors.filter({ $0.parent == nil })
print("Actors without parents: \(parentlessActors)")

//: ### Part 2

guard
    parentlessActors.count == 1,
    let rootParent = parentlessActors.first
else {
    fatalError("Found invalid configuration: \(parentlessActors.count) actors with no parents.")
}

/// Determine which item in a list is different from the others. Returns nil if none of the
/// items is unique.
func oddManOut(actors: [Actor]) -> Actor? {
    let weights = actors.map({ $0.totalWeight }).sorted()
    let weightSet = Set(weights)
    // Check to see if all of the weights are the same
    if weightSet.count == 1 { return nil }
    let oddWeight = weights[0] == weights[1] ? weights.last! : weights[0]
    return actors.filter({ $0.totalWeight == oddWeight }).first!
}

/// Recursively prints a branch of the tree.
func printTree(from actor: Actor, indent: Int = 0) {
    let linePrefix = prefix(forIndent: indent)
    print("\(linePrefix)\(actor.shortDescription)")
    for child in actor.children {
        printTree(from: child, indent: indent + 1)
    }
}

func prefix(forIndent indent: Int) -> String
{
    var str = ""
    for _ in 0..<indent { str.append("+---") }
    return str
}

var actor = rootParent

repeat {
    guard let oddActor = oddManOut(actors: actor.children) else {
        // This actor's children are balanced, it must be the culprit.
        break
    }
    print("odd actor: \(oddActor)")
    actor = oddActor
} while true
print("Found the incorrect actor: \(actor.name)")
print("Here are its siblings:")
actor.parent!.children.forEach({ print($0.shortDescription) })


//: [Previous Page](@previous) | [Next Page](@next)
