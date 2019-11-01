import XCTest
@testable import Brik

final class BrikTests: XCTestCase {

    let brick = Brik { _ in
        UILabel()
            .tag(1)
            .accessibilityIdentifier("one")
        UILabel()
            .tag(2)
            .accessibilityIdentifier("two")
        UIButton()
            .tag(3)
            .accessibilityIdentifier("three")
    }

    func testChildNumber() {
        XCTAssertEqual(brick.allChildsAdded().count, 3)
        XCTAssertEqual(brick.allChilds().count, 4)
    }

    func testGetChildWithTag() {
        XCTAssertTrue(brick[1] is UILabel)
        XCTAssertNotNil(brick[1])
        XCTAssertNotNil(brick[1, UILabel.self])
    }

    func testGetChildWithName() {
        XCTAssertEqual(brick["one"].accessibilityIdentifier, "one")
        XCTAssertTrue(brick["one"] is UILabel)
    }

    func testChildHasUpdatedText() {
        brick.child(childName: "one", class: UILabel.self) { label in
            label.text = "hello"
        }

        XCTAssertEqual(brick["one", UILabel.self].text, "hello")
        XCTAssertNotEqual(brick["one", UILabel.self].text, "salut")
    }

    static var allTests = [
        ("testChildNumber", testChildNumber),
        ("testGetChildWithTag", testGetChildWithTag),
        ("testChildHasUpdatedText", testChildHasUpdatedText),
        ("testGetChildWithName", testGetChildWithName),
    ]
}
