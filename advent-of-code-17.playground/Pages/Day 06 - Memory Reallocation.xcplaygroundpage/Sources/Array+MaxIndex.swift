import Swift

extension Array where Element: Comparable {
    var maxIndex: Int {
        guard let item = self.sorted().last else {
            fatalError("Cannot be called on an empty array.")
        }
        return self.index(of: item)!
    }
}


