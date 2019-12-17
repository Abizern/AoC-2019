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
    func testImporter() {
        let s = stationImporter(input)
        let expectation = [Asteroid(x: 0, y: 2),
                           Asteroid(x: 1, y: 0),
                           Asteroid(x: 1, y: 2),
                           Asteroid(x: 2, y: 2),
                           Asteroid(x: 3, y: 2),
                           Asteroid(x: 3, y: 4),
                           Asteroid(x: 4, y: 0),
                           Asteroid(x: 4, y: 2),
                           Asteroid(x: 4, y: 3),
                           Asteroid(x: 4, y: 4)
        ]

        XCTAssertEqual(Set(s), Set(expectation))
    }

    func testCountVisible() {
        let target = Asteroid(x: 3, y: 4)
        let list = stationImporter(input)
        let newTarget = countVisible(target, list)
        XCTAssertEqual(newTarget.visibility, 8)
    }

    func testExample1() {
        let list = stationImporter(input)
        let target = findTarget(list)
        XCTAssertEqual(target.visibility, 8)
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
//        let list = stationImporter(input)
//        let target = findTarget(list)
//        XCTAssertEqual(target.x, 5)
//        XCTAssertEqual(target.y, 8)
//        XCTAssertEqual(target.visibility, 33)
        let target = Asteroid(x: 5, y: 8)
        let list = stationImporter(input)
        let newTarget = countVisible(target, list)
        XCTAssertEqual(newTarget.visibility, 33)
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
        XCTAssertEqual(target.x, 1)
        XCTAssertEqual(target.y, 2)
        XCTAssertEqual(target.visibility, 35)
    }


}
