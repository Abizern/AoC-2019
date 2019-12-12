public struct IntCode {
    var list: [Int]
    var phase: Int // For Day7 Amplifier

    public lazy var result = list[0]

    public var diagnostics = [Int]()

    public init(_ list: [Int], phase: Int = 0) {
        self.list = list
        self.phase = phase
    }

    func value(at n: Int, mode: Mode) -> Int {
        switch mode {
        case .immediate:
            return n
        case .position:
            return list[n]
        }
    }

    enum OpCode: Int {
        case add = 1
        case mult = 2
        case input = 3
        case output = 4
        case jumpIfTrue = 5
        case jumpIfFalse = 6
        case lessThan = 7
        case equals = 8
        case halt = 99

        init<S: Sequence>(_ digits: S) where S.Element == Int {
            let n = digits.reduce(into: 0) { (accum, n) in
                accum = accum * 10 + n
            }
            self = OpCode(rawValue: n)!
        }

        var length: Int {
            switch self {
            case .add, .mult:
                return 4
            case .input, .output:
                return 2
            case .jumpIfTrue, .jumpIfFalse:
                return 3
            case .lessThan, .equals:
                return 4
            case .halt:
                return 0
            }
        }
    }

    static func decomposeInstruction(_ n: Int) -> (Mode, Mode, Mode, OpCode) {
        let digits = String(n).compactMap { $0.wholeNumberValue }

        switch digits.count {
        case 1:
            return (.position, .position, .position, OpCode(rawValue: n)!)
        case 2:
            return (.position, .position, .position, OpCode(digits))
        case 3:
            return (.position, .position, Mode(digits[0]), OpCode(digits.dropFirst()))
        case 4:
            return (.position, Mode(digits[0]), Mode(digits[1]), OpCode(digits.dropFirst(2)))
        case 5:
            return (Mode(digits[0]), Mode(digits[1]), Mode(digits[2]), OpCode(digits.dropFirst(3)))
        default:
            fatalError("Too many digits to decompose from \(n)")
        }
    }


    enum Mode {
        case position
        case immediate

        init(_ n: Int) {
            switch n {
            case 0:
                self = .position
            case 1:
                self = .immediate
            default:
                fatalError("Invalid parameter mode \(n)")
            }
        }
    }

    public mutating func run() {
        run(inputs: [0], runToEnd: true)
    }

    public mutating func run(inputs: [Int] = [0], runToEnd: Bool = true) {
        let end = list.count
        var inputs = inputs
        var cursor = 0

        while cursor < end && (runToEnd || diagnostics.isEmpty) {
            let (_, m2, m1, op) = IntCode.decomposeInstruction(list[cursor])
            guard cursor + op.length - 1 < end else { fatalError("overrun") }
            guard op != .halt else { break }

            var newCursor = cursor + op.length

            switch op {
            case .add:
                list[list[cursor + 3]] = value(at: list[cursor + 1], mode: m1) + value(at: list[cursor + 2], mode: m2)
            case .mult:
                list[list[cursor + 3]] = value(at: list[cursor + 1], mode: m1) * value(at: list[cursor + 2], mode: m2)
            case .input:
                list[list[cursor + 1]] = inputs[0]
                inputs = Array(inputs.dropFirst())
            case .output:
                diagnostics.append(value(at: list[cursor + 1], mode: m1))
            case .jumpIfTrue:
                if value(at: list[cursor + 1], mode: m1) != 0 {
                    newCursor = value(at: list[cursor + 2], mode: m2)
                }
            case .jumpIfFalse:
                if value(at: list[cursor + 1], mode: m1) == 0 {
                    newCursor = value(at: list[cursor + 2], mode: m2)
                }
            case .lessThan:
                list[list[cursor + 3]] = value(at: list[cursor + 1], mode: m1) < value(at: list[cursor + 2], mode: m2) ? 1 : 0
            case .equals:
                list[list[cursor + 3]] = value(at: list[cursor + 1], mode: m1) == value(at: list[cursor + 2], mode: m2) ? 1 : 0
            default:
                print("Oops: instruction \(list[cursor])")
            }

            cursor = newCursor
        }
    }

    public func applyingPair(_ pair: Int) -> IntCode {
        var list = self.list
        let verb = pair % 100
        let noun = (pair - verb) / 100

        list[1] = noun
        list[2] = verb

        return IntCode(list)
    }
}

public extension IntCode {
    func withPhase(_ n: Int) -> IntCode {
        IntCode(list, phase: n)
    }

    mutating func runAmplifier(input: Int) {
        run(inputs: [phase, input], runToEnd: false)
    }
}
