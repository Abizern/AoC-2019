import Foundation

func getInput(_ string: String) -> [[String]] {
    string
        .components(separatedBy: .newlines)
        .map { $0.components(separatedBy: ")") }
}

func main() {
    print("Hello")
}
