import Overture

// Convenience functions for reading inputs

let trimmingNewlines = flip(String.trimmingCharacters(in:))(.newlines)
let separatedByNewlines = flip(String.components(separatedBy:))(.newlines)
let convertToLines = pipe(trimmingNewlines, separatedByNewlines)
let separatedByCommas = flip(String.components(separatedBy:))(",")
