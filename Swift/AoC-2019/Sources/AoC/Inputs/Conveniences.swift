import Overture

// Convenience functions for reading inputs

let trimmingNewlines = flip(String.trimmingCharacters(in:))(.newlines)
let separatedByNewlines = flip(String.components(separatedBy:))(.newlines)
let convertToLines = pipe(trimmingNewlines, separatedByNewlines)
let separatedByCommas = flip(String.components(separatedBy:))(",")

/// Decomposes an `Int` into its digits
func digits(_ n: Int) -> [Int] {
    String(n).compactMap { $0.wholeNumberValue }
}
