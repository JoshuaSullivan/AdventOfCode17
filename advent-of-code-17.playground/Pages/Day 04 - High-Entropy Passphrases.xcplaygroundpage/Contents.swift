//: # Advent of Code
//: ## Day 04: High-entropy Passphrases
import Foundation

guard
    let inputURL = Bundle.main.url(forResource: "input", withExtension: "txt"),
    let input = try? String(contentsOf: inputURL, encoding: .utf8)
else {
    fatalError("Could not find input file.")
}

let phrases = input.split(separator: "\n").map({ $0.split(separator: " ") })

//: ### Part 1

extension Array where Element: Comparable {
    var containsDuplicates: Bool {
        for (index, element) in self.enumerated() {
            for otherElement in self.dropFirst(index + 1) {
                if element == otherElement { return true }
            }
        }
        return false
    }
}
let validPhraseCount: Int = phrases.reduce(0, {
    return $0 + ($1.containsDuplicates ? 0 : 1)
})
print("Found \(validPhraseCount) valid phrases.")

//: ### Part 2

extension StringProtocol {
    func isAnagram(of otherString: String) -> Bool {
        guard self.count == otherString.count else { return false }
        let anagram = self.sorted() == otherString.sorted()
        return anagram
    }
}

let newValidPhraseCount: Int = phrases.reduce(0, {
    result, line in
    for (index, word) in line.enumerated() {
        for otherWord in line.dropFirst(index + 1) {
            if word.isAnagram(of: String(otherWord)) {
                return result
            }
        }
    }
    return result + 1
})

print("Found \(newValidPhraseCount) passphrases which did not contain anagrams.")

//: [Previous Page](@previous) | [Next Page](@next)

