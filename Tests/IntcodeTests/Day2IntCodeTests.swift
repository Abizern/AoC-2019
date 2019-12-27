import XCTest
@testable import Intcode

final class Day2IntCodeTests: XCTestCase {
    func testExamplePart1() {
        let examples = [
            [1,9,10,3,2,3,11,0,99,30,40,50],
            [1,0,0,0,99],
            [2,3,0,3,99],
            [2,4,4,5,99,0],
            [1,1,1,4,99,5,6,0,99]
        ]
        let expectations = [3500, 2, 2, 2, 30]
        let firstValues = examples.map { (list: [Int]) -> Int in
            var computer = Intcode.init(list)
            computer.runToEnd()
            return computer.firstValue
        }

        XCTAssertEqual(firstValues, expectations)
    }
}
