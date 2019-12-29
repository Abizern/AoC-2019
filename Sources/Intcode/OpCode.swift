import Foundation

struct OpCode {
    let operation: Operation
    let modes: (Mode, Mode, Mode)

    init(operation: Operation, modes: (Mode, Mode, Mode) = (.position, .position, .position)) {
        self.operation = operation
        self.modes = modes
    }

    init(_ n: Int) {
        let digits = n.digits
        switch digits.count {
        case 1, 2:
            self = .init(operation: Operation(n))
        case 3:
            self = .init(operation: Operation(digits.dropFirst()),
                         modes: (Mode(digits[0]),
                                 .position,
                                 .position))
        case 4:
            self = .init(operation: Operation(digits.dropFirst(2)),
                         modes: (Mode(digits[1]),
                                 Mode(digits[0]),
                                 .position))
        case 5:
            self = .init(operation: Operation(digits.dropFirst(2)),
                         modes: (Mode(digits[2]),
                                 Mode(digits[1]),
                                 Mode(digits[0])))
        default:
            fatalError("Too many digits to decompose from \(n)")
        }
    }

    enum Operation: Int {
        case add = 1
        case multiply = 2
        case input = 3
        case output = 4
        case jumpIfTrue = 5
        case jumpIfFalse = 6
        case lessThan = 7
        case equals = 8
        case halt = 99

        init(_ n: Int) {
            self = Operation(rawValue: n) ?? .halt
        }

        init(_ slice: ArraySlice<Int>) {
            self = .init(slice[slice.endIndex - 2] * 10 + slice[slice.endIndex - 1])
        }
    }

    enum Mode: Int {
        case position = 0
        case immediate = 1

        init(_ n: Int) {
            self = Mode(rawValue: n) ?? .position
        }
    }
}

extension OpCode {
    var length: Int {
        switch operation {
        case .add, .multiply, .lessThan, .equals:
            return 4
        case .input, .output:
            return 2
        case .jumpIfTrue, .jumpIfFalse:
            return 3
        case .halt:
            return 0
        }
    }
}

/// Decomposes an `Int` into its digits
private extension Int {
    var digits: [Int] {
        String(self).compactMap { $0.wholeNumberValue }
    }
}
