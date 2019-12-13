import XCTest
@testable import AoCLibrary

final class ImporterTests: XCTestCase {
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
}
