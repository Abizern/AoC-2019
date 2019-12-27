import Foundation

enum OpCode: Int {
    case add = 1
    case multiply = 2
    case halt = 99
}

extension OpCode {
    var length: Int {
        switch self {
        case .add, .multiply:
            return 4
        case .halt:
            return 0
        }
    }
}
