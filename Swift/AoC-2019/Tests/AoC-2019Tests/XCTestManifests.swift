import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AoC_2019Tests.allTests),
    ]
}
#endif
