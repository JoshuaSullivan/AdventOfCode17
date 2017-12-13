//: [Previous](@previous)

import Foundation

class Villager: Hashable, Equatable {
    
    private(set) static var lookup: [Int : Villager] = [:]
    
    let id: Int
    let linkList: [Int]
    
    init(string: String) {
        let mainParts = string
            .replacingOccurrences(of: " <-> ", with: "=")
            .split(separator: "=")
        id = Int(String(mainParts[0]))!
        linkList = String(mainParts[1])
            .replacingOccurrences(of: ", ", with: ",")
            .split(separator: ",")
            .flatMap({ Int($0) })
        Villager.lookup[id] = self
    }
    
    var hashValue: Int {
        return id
    }
    
    static func ==(lhs: Villager, rhs: Villager) -> Bool {
        return lhs.id == rhs.id
    }
}

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let rawInput = try? String(contentsOf: inputURL, encoding: .utf8)
    else {
        fatalError("Could not find input file.")
}
let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)
let allVillagers = input
    .split(separator: "\n")
    .map({ String($0) })
    .map({ Villager(string: $0) })
let villagerMap: [Int : Villager] = allVillagers.reduce(into: [:], { $0[$1.id] = $1 })

func traverseList(index: Int, encounteredIndices: inout [Int]) {
    guard let v = villagerMap[index] else {
        fatalError("Encountered an ID with no associated Villager.")
    }
    encounteredIndices.append(index)
    for childIndex in v.linkList.filter({ !encounteredIndices.contains($0) }) {
        traverseList(index: childIndex, encounteredIndices: &encounteredIndices)
    }
}

var zeroNeighbors: [Int] = []
traverseList(index: 0, encounteredIndices: &zeroNeighbors)
print("Found \(zeroNeighbors.count) neighbors to 0.")

var coveredVillagers: [Int] = []
var groups: Int = 0
for index in (0..<villagerMap.keys.count) {
    guard !coveredVillagers.contains(index) else { continue }
    var neighbors: [Int] = []
    traverseList(index: index, encounteredIndices: &neighbors)
    coveredVillagers.append(contentsOf: neighbors)
    groups += 1
}

print("Encountered \(groups) groups.")

//: [Next](@next)
