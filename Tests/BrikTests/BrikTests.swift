import XCTest
@testable import Brik

final class BrikTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Brik().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
