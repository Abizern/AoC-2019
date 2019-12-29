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

    public func input(_ n: Int) {
        inputs.enqueue(n)
    }

    public var output: Int? {
        outputs.dequeue()
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
        var newCursor = cursor + opCode.length
        switch opCode.operation {
        case .add:
            list[list[cursor + 3]] =
                parameter(value: list[cursor + 1], mode: opCode.modes.0) +
                parameter(value: list[cursor + 2], mode: opCode.modes.1)
        case .multiply:
            list[list[cursor + 3]] =
                parameter(value: list[cursor + 1], mode: opCode.modes.0) *
                parameter(value: list[cursor + 2], mode: opCode.modes.1)
        case .input:
            guard let n = inputs.dequeue() else { fatalError("No inputs provided") }
            list[list[cursor + 1]] = n
        case .output:
            outputs.enqueue(parameter(value: list[cursor + 1], mode: opCode.modes.0))
        case .halt:
            isHalted = true
        case .jumpIfTrue:
            if parameter(value: list[cursor + 1], mode: opCode.modes.0) != 0 {
                newCursor = parameter(value: list[cursor + 2], mode: opCode.modes.1)
            }
        case .jumpIfFalse:
            if parameter(value: list[cursor + 1], mode: opCode.modes.0) == 0 {
                newCursor = parameter(value: list[cursor + 2], mode: opCode.modes.1)
            }
        case .lessThan:
            list[list[cursor + 3]] =
                parameter(value: list[cursor + 1], mode: opCode.modes.0) <
                parameter(value: list[cursor + 2], mode: opCode.modes.1) ? 1 : 0
        case .equals:
            list[list[cursor + 3]] =
                parameter(value: list[cursor + 1], mode: opCode.modes.0) ==
                parameter(value: list[cursor + 2], mode: opCode.modes.1) ? 1 : 0
        }

        cursor = newCursor
    }

    func step() {
        with(readOpCode(), apply)
    }
}

// Day5 support

public extension Intcode {
    var diagnosticOutput: Int {
        outputs.peekAll().last ?? 0
    }
}
