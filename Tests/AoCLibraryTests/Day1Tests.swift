import XCTest
@testable import AoCLibrary

final class Day1Tests: XCTestCase {
    func testFuelRequired() {
        XCTAssertEqual(fuelRequiredFor(12), 2)
        XCTAssertEqual(fuelRequiredFor(14), 2)
        XCTAssertEqual(fuelRequiredFor(1969), 654)
        XCTAssertEqual(fuelRequiredFor(100756), 33583)
    }

    func testRecursiveFuelRequired() {
        XCTAssertEqual(recursiveFuelRequiredFor(14), 2)
        XCTAssertEqual(recursiveFuelRequiredFor(1969), 966)
        XCTAssertEqual(recursiveFuelRequiredFor(100756), 50346)
    }
}
