import Foundation
import Overture

public final class Intcode {
    private var list: [Int]
    private var cursor = 0
    private var isHalted = false
    private var outputs = Queue<Int>()
    private var inputs = Queue<Int>()

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
        OpCode(list[cursor])
    }

    func parameter(value: Int, mode: OpCode.Mode) -> Int {
        switch mode {
        case.position:
            return list[value]
        case .immediate:
            return value
        }
    }

    func apply(_ opCode: OpCode) {
        switch opCode.operation {
        case .add:
            let target = list[cursor + opCode.length - 1]
            list[target] =
                parameter(value: list[cursor + 1], mode: opCode.modes.0) +
                parameter(value: list[cursor + 2], mode: opCode.modes.1)
        case .multiply:
            let target = list[cursor + opCode.length - 1]
            list[target] =
                parameter(value: list[cursor + 1], mode: opCode.modes.0) *
                parameter(value: list[cursor + 2], mode: opCode.modes.1)
        case .halt:
            isHalted = true
        }
    }

    func step() {
        let opCode = readOpCode()
        apply(opCode)
        cursor += opCode.length
    }
}
