import XCTest
import AoCLibrary

final class PermutationsTests: XCTestCase {
    func testPermutations() {
        let array = [1, 2, 3]
        let perms = permutations(array)
        let expectation = [[1, 2, 3], [2, 1, 3], [2, 3, 1], [1, 3, 2], [3, 1, 2], [3, 2, 1]]
        XCTAssertEqual(perms.count, expectation.count)
        expectation.forEach { (exp) in
            XCTAssertTrue(perms.contains(exp))
        }
    }
}

final class MultiplesTests: XCTestCase {
    func test_gcd() {
        XCTAssertEqual(gcd(3, 9), 3)
    }

    func test_lcm() {
        XCTAssertEqual(lcm(3,4), 12)
    }
}
