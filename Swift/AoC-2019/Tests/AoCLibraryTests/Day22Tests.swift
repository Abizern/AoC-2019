import Foundation
import XCTest
@testable import AoCLibrary

final class Day22Tests: XCTestCase {

    func testDatum() {
        var datum = Datum(index: 0, length: 3)
        datum.newIndex(2)
        XCTAssertEqual(datum.index, 2)
    }

    func testReverse() {
        let result = (0..<4)
            .map { Datum(index: $0, length: 4) }
            .map { apply($0, Shuffle.reverse) }

        XCTAssertEqual(result, [3, 2, 1, 0])
    }

    func testCutPositive() {
        let result = (0..<7)
            .map { Datum(index: $0, length: 7) }
            .map { apply($0, Shuffle.cut(3)) }

        XCTAssertEqual(result, [4, 5, 6, 0, 1, 2, 3])
    }

    func testCutNegative() {
        let data = (0..<7)
            .map { Datum(index: $0, length: 7) }

        XCTAssertEqual(
            data.map { apply($0, Shuffle.cut(3)) },
            data.map { apply($0, Shuffle.cut(-4)) })
    }

    func testIncrement() {
        let result = (0..<10)
            .map { Datum(index: $0, length: 10) }
            .map { apply($0, Shuffle.increment(3)) }

        XCTAssertEqual(result, [0, 3, 6, 9, 2, 5, 8, 1, 4, 7])
    }

    func testDecrementHead() {
        let datum = Datum(index: 0, length: 10)
        let newIndex = apply(datum, .decrement(3))

        XCTAssertEqual(newIndex, 0)
    }

    func testDecrementFirstPass() {
        let datum = Datum(index: 3, length: 10)
        let newIndex = apply(datum, .decrement(3))

        XCTAssertEqual(newIndex, 1)
    }

    func testDecrementSecondPass() {
        let datum = Datum(index: 2, length: 10)
        let newIndex = apply(datum, .decrement(3))

        XCTAssertEqual(newIndex, 4)
    }

    func testPart2UsingPart1Input() {
        let inverted = part1Input.reversed().map(invert)
        let datum = Datum(index: 1498, length: 10007)
        let shuffles = Shuffles(shuffles: inverted)

        let result = trackDatum(datum: datum, shuffles: shuffles)
        XCTAssertEqual(result, 2019)
    }

}
