import Foundation

public struct IntCode {
    var list: [Int]

    public init(_ list: [Int]) {
        self.list = list
    }

    enum OpCode {
        case add
        case mult
        case halt

        init(_ n: Int) {
            switch n {
            case 1:
                self = .add
            case 2:
                self = .mult
            case 99:
                self = .halt
            default:
                fatalError("Invalid OpCode")
            }
        }

        var length: Int {
            switch self {
            case .add, .mult:
                return 4
            case .halt:
                return 0
            }
        }
    }

    public var output: Int {
        var list = self.list
        let end = list.count
        var cursor = 0

        while cursor < end {
            let op = OpCode(list[cursor])
            guard op != .halt, (cursor + op.length - 1 < end) else  { break }
            let (p1, p2, address) = (list[cursor + 1],
                                     list[cursor + 2],
                                     list[cursor + 3])


            switch op {
            case .add:
                list[address] = list[p1] + list[p2]
            case .mult:
                list[address] = list[p1] * list[p2]
            default:
                fatalError("Unexpected item in the bagging area")
            }

            cursor += op.length
        }
        return list[0]
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
