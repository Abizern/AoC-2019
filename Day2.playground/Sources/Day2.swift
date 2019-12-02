import Foundation

public func getInput(_ name: String = "Input") -> [Int] {
    guard
        let url = Bundle.main.url(forResource: name, withExtension: "txt"),
        let text = try? String(contentsOf: url)
        else { fatalError("Unable to read the input file \(name).txt from the bundle") }

   return text
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: ",")
        .compactMap(Int.init)
}

public let input = getInput()

public func output(_ list: [Int]) -> Int {
    var list = list

    for n in stride(from: 0, to: input.count, by: 4) {
        let (op, p1, p2, address) = (list[n],
                                     list[n + 1],
                                     list[n + 2],
                                     list[n + 3])
        guard op != 99 else { break }

        switch op {
        case 1:
            list[address] = list[p1] + list[p2]
        case 2:
            list[address] = list[p1] * list[p2]
        default:
            fatalError("Unexpected item in bagging area")
        }
    }
    return list[0]
}

public func output(list: [Int], pair: Int) -> Int {
    let newInput = list.applyingPair(pair)
    return output(newInput)
}

public extension Array where Element == Int {
    func applyingPair(_ pair: Int) -> [Int] {
        var array = self
        let verb = pair % 100
        let noun = (pair - verb) / 100

        array[1] = noun
        array[2] = verb

        return array
    }
}
