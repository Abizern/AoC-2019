import Foundation

let inputs = (146810 ... 612564).map { $0.digits }

extension Int {
    var digits: [Int] {
        String(self).compactMap { $0.wholeNumberValue }
    }
}

extension Array where Element == Int {
    var isIncreasing: Bool {
        var cursor = 0
        var result = true

        for digit in self {
            if digit < cursor {
                result = false
                break
            }
            cursor = digit
        }

        return result
    }

    var hasDouble: Bool {
        var cursor = self[0]
        var result = false

        for digit in self.dropFirst() {
            if digit == cursor {
                result = true
                break
            }
            cursor = digit
        }

        return result
    }

    var hasStrictDouble: Bool {
        func aggregate(_ dict: inout [Int: Int], _ digit: Int) {
            dict[digit, default: 0] += 1
        }

        return self.reduce(into: [:], aggregate)
            .values
            .contains(2)
    }
}

func isValid(_ digits: [Int]) -> Bool {
    digits.isIncreasing && digits.hasDouble
}

func isStrictlyValid(_ digits: [Int]) -> Bool {
    digits.isIncreasing && digits.hasStrictDouble
}


public let part1 = inputs
    .filter(isValid)
    .count

public let part2 = inputs
    .filter(isStrictlyValid)
    .count
