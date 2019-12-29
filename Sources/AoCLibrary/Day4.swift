import Overture

typealias Digits = [Int]

public enum Day4 {
    public static func part1(_ inputs: (Int, Int)) -> Int {
        inputList(inputs)
            .filter { $0.isValid }
            .count
    }

    public static func part2(_ inputs: (Int, Int)) -> Int {
        inputList(inputs)
            .filter { $0.isStrictlyValid }
            .count
    }
}

private extension Day4 {
    private static func inputList(_ inputs: (Int, Int)) -> [Digits] {
        let (start, end) = inputs
        return (start ... end).map(digits)
    }
}

extension Array where Element == Int {
    var isIncreasing: Bool {
        sorted() == self
    }

    var hasDouble: Bool {
        Set(self).count < self.count
    }

    var hasStrictDouble: Bool {
        reduce(into: [Int: Int]()) { accum, n in
            accum[n, default: 0] += 1
        }
        .values
        .contains(2)
    }

    var isValid: Bool {
        isIncreasing && hasDouble
    }

    var isStrictlyValid: Bool {
        isIncreasing && hasStrictDouble
    }
}
