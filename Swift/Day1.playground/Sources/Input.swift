import Foundation

/// Loads the input file as an array of strings from the Resources folder of the playground
///
/// - Each line of the input file is converted to a string and the file is returned as an array of these strings
/// - Empty lines are filtered out
/// 
/// - Parameter name: The name of the file to load, without the extension. Defaults to "Input"
public func getInput(name: String = "Input") -> [String] {
    guard
        let url = Bundle.main.url(forResource: name, withExtension: "txt"),
        let text = try? String(contentsOf: url)
        else { fatalError("Unable to read the input file \(name).txt from the bundle") }

    return text
        .components(separatedBy: "\n")
        .filter { $0 != "" }
}
