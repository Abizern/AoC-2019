import Foundation

public class Intcode {
    private var list: [Int]
    private var cursor = 0
    private var isHalted = false

    public init(_ list: [Int]) {
        self.list = list
    }

    public func runToEnd() {
        while !isHalted {
            step()
        }
    }

    public var firstValue: Int {
        list[0]
    }

    public func applyAlarmState(_ state: Int) {
        let verb = state % 100
        let noun = (state - verb) / 100
        list[1] = noun
        list[2] = verb
    }
}

private extension Intcode {
    func readOpCode() -> OpCode {
        OpCode(rawValue: list[cursor])! // Expected to crash
    }

    func parametersFor(_ opCode: OpCode) -> ArraySlice<Int> {
        list[cursor ..< cursor + opCode.length].dropFirst()
    }

    func apply(_ opCode: OpCode, _ parameters: ArraySlice<Int>) {
        let first = parameters.startIndex
        let last = parameters.endIndex - 1
        switch opCode {
        case .add:
            let target = parameters[last]
            list[target] = list[parameters[first]] + list[parameters[first + 1]]
        case .multiply:
            let target = parameters[last]
            list[target] = list[parameters[first]] * list[parameters[first + 1]]
        case .halt:
            isHalted = true
        }
    }

    func step() {
        let opCode = readOpCode()
        let parameters = parametersFor(opCode)
        apply(opCode, parameters)
        cursor += opCode.length
    }
}
