import XCTest
@testable import AoCLibrary

final class Day4Tests: XCTestCase {
    func testPart1Examples() {
        XCTAssertTrue(digits(111111).isValid)
        XCTAssertFalse(digits(223450).isValid)
        XCTAssertFalse(digits(123789).isValid)
    }

    func testPart2Examples() {
        XCTAssertTrue(digits(112233).isStrictlyValid)
        XCTAssertFalse(digits(123444).isStrictlyValid)
        XCTAssertTrue(digits(111122).isStrictlyValid)
    }
}
