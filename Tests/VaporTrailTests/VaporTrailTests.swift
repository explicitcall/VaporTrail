import XCTest
@testable import VaporTrail

final class VaporTrailTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(VaporTrail().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
