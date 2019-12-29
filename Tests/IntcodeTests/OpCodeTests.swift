import XCTest
@testable import Intcode

final class OpCodeTests: XCTestCase {
    func testLength() {
        XCTAssertEqual(OpCode(operation: .add).length, 4)
        XCTAssertEqual(OpCode(operation: .multiply).length, 4)
        XCTAssertEqual(OpCode(operation: .input).length, 2)
        XCTAssertEqual(OpCode(operation: .output).length, 2)
        XCTAssertEqual(OpCode(operation: .jumpIfTrue).length, 3)
        XCTAssertEqual(OpCode(operation: .jumpIfFalse).length, 3)
        XCTAssertEqual(OpCode(operation: .lessThan).length, 4)
        XCTAssertEqual(OpCode(operation: .equals).length, 4)
        XCTAssertEqual(OpCode(operation: .halt).length, 0)
    }

    func testModes() {
        let opCode = OpCode(1001)
        XCTAssertEqual(opCode.operation, .add)
        let modes = opCode.modes
        XCTAssertEqual(modes.0, OpCode.Mode.position)
        XCTAssertEqual(modes.1, OpCode.Mode.immediate)
    }
}
