import Foundation

public enum Day4 {
    static func isIncreasing(_ digits: [Int]) -> Bool {
        digits.sorted() == digits
    }

    static func hasDouble(_ digits: [Int]) -> Bool {
        Set(digits).count < digits.count
    }

    static func hasStrictDouble(_ digits: [Int]) -> Bool {
        func aggregate(_ dict: inout [Int: Int], _ digit: Int) {
            dict[digit, default: 0] += 1
        }

        return digits
            .reduce(into: [:], aggregate)
            .values
            .contains(2)
    }

    static func isValid(_ digits: [Int]) -> Bool {
        isIncreasing(digits) && hasDouble(digits)
    }

    static func isStrictlyValid(_ digits: [Int]) -> Bool {
        isIncreasing(digits) && hasStrictDouble(digits)
    }

    public static func part1(_ inputs: [[Int]]) -> Int {
        inputs.filter(isValid).count
    }

    public static func part2(_ inputs: [[Int]]) -> Int {
        inputs.filter(isStrictlyValid).count
    }
}
