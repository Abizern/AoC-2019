import XCTest
@testable import Intcode

final class OpCodeTests: XCTestCase {
    func testLength() {
        XCTAssertEqual(OpCode.add.length, 4)
        XCTAssertEqual(OpCode.multiply.length, 4)
        XCTAssertEqual(OpCode.halt.length, 0)
    }
}
