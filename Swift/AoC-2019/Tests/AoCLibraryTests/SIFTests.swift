import XCTest
@testable import AoCLibrary

final class SIFTests: XCTestCase {
    func testExample1() {
        let input = "123456789012".compactMap { $0.wholeNumberValue }
        let result = split(width: 3, height: 2, list: input)
        XCTAssertEqual(result[0], [1, 2, 3, 4, 5, 6])
        XCTAssertEqual(result[1], [7, 8, 9, 0, 1, 2])
    }

    func testResolved() {
        let input = "0222112222120000".compactMap { $0.wholeNumberValue }
        let sif = SIF(width: 2, height: 2, inputs: input)
        let resolved = sif.resolved
        XCTAssertEqual(resolved[0], [0, 1])
        XCTAssertEqual(resolved[1], [1, 0])
    }
}
