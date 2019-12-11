import Foundation

func getInput(_ name: String = "Input") -> IntCode {
    guard
        let url = Bundle.main.url(forResource: name, withExtension: "txt"),
        let text = try? String(contentsOf: url)
        else { fatalError("Unable to read the input file \(name).txt from the bundle") }

    return IntCode(text
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: ",")
        .compactMap(Int.init))
}

public let input = getInput()
