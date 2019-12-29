import XCTest
import AoCLibrary

let input1 = """
R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83
"""

let input2 = """
R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
"""


final class Day3Tests: XCTestCase {
    func testPart1Examples() {
        XCTAssertEqual(Day3.part1(input1), 159)
        XCTAssertEqual(Day3.part1(input2), 135)
    }

    func testPart2Examples() {
        XCTAssertEqual(Day3.part2(input1), 610)
        XCTAssertEqual(Day3.part2(input2), 410)
    }

}
