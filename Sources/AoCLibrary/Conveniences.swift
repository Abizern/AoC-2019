import Overture

// Convenience functions for reading inputs

public let trimmingNewlines = flip(String.trimmingCharacters(in:))(.newlines)
public let trimmingWhitespace = flip(String.trimmingCharacters(in:))(.whitespaces)
public let separatedByNewlines = flip(String.components(separatedBy:))(.newlines)
public let convertToLines = pipe(trimmingNewlines, separatedByNewlines)
public let separatedByCommas = flip(String.components(separatedBy:))(",")

public func convertToIntArray(_ string: String) -> [Int] {
    with(string, separatedByNewlines).compactMap(Int.init)
}

/// Decomposes an `Int` into its digits
public func digits(_ n: Int) -> [Int] {
    String(n).compactMap { $0.wholeNumberValue }
}
