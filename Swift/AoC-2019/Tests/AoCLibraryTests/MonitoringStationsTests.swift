import XCTest
@testable import AoCLibrary

final class MonitoringStationTests: XCTestCase {
    let input =
    """
.#..#
.....
#####
....#
...##
"""
    func testExample1() {
        let list = stationImporter(input)
        let target = findTarget(list)
        XCTAssertEqual(target.visibility, 8)
        XCTAssertEqual(target, Asteroid(x: 3, y: 4))
    }

    func testExample2() {
        let input = """
......#.#.
#..#.#....
..#######.
.#.#.###..
.#..#.....
..#....#.#
#..#....#.
.##.#..###
##...#..#.
.#....####
"""
        let list = stationImporter(input)
        let target = findTarget(list)
        XCTAssertEqual(target.visibility, 33)
        XCTAssertEqual(target, Asteroid(x: 5, y: 8))
    }

    func testExample3() {
        let input = """
#.#...#.#.
.###....#.
.#....#...
##.#.#.#.#
....#.#.#.
.##..###.#
..#...##..
..##....##
......#...
.####.###.
"""
        let list = stationImporter(input)
        let target = findTarget(list)
        XCTAssertEqual(target, Asteroid(x: 1, y: 2))
        XCTAssertEqual(target.visibility, 35)
    }
}
