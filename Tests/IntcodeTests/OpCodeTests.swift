import XCTest
@testable import Intcode

final class OpCodeTests: XCTestCase {
    func testLength() {
        XCTAssertEqual(OpCode(operation: .add).length, 4)
        XCTAssertEqual(OpCode(operation: .multiply).length, 4)
        XCTAssertEqual(OpCode(operation: .halt).length, 0)
    }
}
