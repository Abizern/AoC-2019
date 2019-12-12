import XCTest
@testable import IntCode

final class IntCodeOpCodeTests: XCTestCase {
    func testInitialiser() {
        XCTAssertEqual(IntCode.OpCode(rawValue: 1), .add)
        XCTAssertEqual(IntCode.OpCode(rawValue: 2), .mult)
        XCTAssertEqual(IntCode.OpCode(rawValue: 3), .input)
        XCTAssertEqual(IntCode.OpCode(rawValue: 4), .output)
        XCTAssertEqual(IntCode.OpCode(rawValue: 99), .halt)

    }

    func testLength() {
        XCTAssertEqual(IntCode.OpCode.add.length, 4)
        XCTAssertEqual(IntCode.OpCode.mult.length, 4)
        XCTAssertEqual(IntCode.OpCode.input.length, 2)
        XCTAssertEqual(IntCode.OpCode.output.length, 2)
        XCTAssertEqual(IntCode.OpCode.halt.length, 0)
    }
}

final class DecomposeInstructionTests: XCTestCase {
    func testDecomposition() {
        let (m1, m2, m3, m4) = IntCode.decomposeInstruction(1002)
        XCTAssertEqual(m1, .position)
        XCTAssertEqual(m2, .immediate)
        XCTAssertEqual(m3, .position)
        XCTAssertEqual(m4, .mult)
    }
}

final class IntCodeTests: XCTestCase {
    func testSimpleDiagnostics() {
        var intCode = IntCode([3, 0, 4, 0, 99])
        intCode.runDiagnostic(input: 1)
        XCTAssertEqual(intCode.diagnostics, [1])
    }

    func testExtendedDiagnosticsDay5Part2() {
        var intCode = IntCode([3,9,8,9,10,9,4,9,99,-1,8])
        intCode.runDiagnostic(input: 8)
        XCTAssertEqual(intCode.diagnostics, [1])

        intCode = IntCode([3,9,8,9,10,9,4,9,99,-1,8])
        intCode.runDiagnostic(input: 9)
        XCTAssertEqual(intCode.diagnostics, [0])

        intCode = IntCode([3,9,7,9,10,9,4,9,99,-1,8])
        intCode.runDiagnostic(input: 7)
        XCTAssertEqual(intCode.diagnostics, [1])

        intCode = IntCode([3,9,7,9,10,9,4,9,99,-1,8])
        intCode.runDiagnostic(input: 8)
        XCTAssertEqual(intCode.diagnostics, [0])

        intCode = IntCode([3,3,1108,-1,8,3,4,3,99])
        intCode.runDiagnostic(input: 7)
        XCTAssertEqual(intCode.diagnostics, [0])

        intCode = IntCode([3,3,1108,-1,8,3,4,3,99])
        intCode.runDiagnostic(input: 8)
        XCTAssertEqual(intCode.diagnostics, [1])

        intCode = IntCode([3,3,1107,-1,8,3,4,3,99])
        intCode.runDiagnostic(input: 9)
        XCTAssertEqual(intCode.diagnostics, [0])

        intCode = IntCode([3,3,1107,-1,8,3,4,3,99])
        intCode.runDiagnostic(input: 7)
        XCTAssertEqual(intCode.diagnostics, [1])
    }

    func testExtendedJumpTestInput_0_or_1() {
        var intCode = IntCode([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9])
        intCode.runDiagnostic(input: 0)
        XCTAssertEqual(intCode.diagnostics, [0])

        intCode = IntCode([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9])
        intCode.runDiagnostic(input: 1)
        XCTAssertEqual(intCode.diagnostics, [1])
    }

    func testMultipleDiagnosticOutput() {
        /// 999 if < 8, 1000 == 8, 1001 > 8
        let intCode = IntCode([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99])

        var sut1 = intCode
        sut1.runDiagnostic(input: 7)
        XCTAssertEqual(sut1.diagnostics, [999])

        var sut2 = intCode
        sut2.runDiagnostic(input: 8)
        XCTAssertEqual(sut2.diagnostics, [1000])

        var sut3 = intCode
        sut3.runDiagnostic(input: 9)
        XCTAssertEqual(sut3.diagnostics, [1001])
    }

}
