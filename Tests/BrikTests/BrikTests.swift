import XCTest
@testable import Brik

final class BrikTests: XCTestCase {

    let brik = Brik { _ in
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

    func testChildNumberWithSimpleBrik() {
        XCTAssertEqual(brik.allChildsAdded().count, 3)
        XCTAssertEqual(brik.allChilds().count, 4)
    }

    func testGetChildWithTagAndWithSimpleBrik() {
        XCTAssertTrue(brik[1] is UILabel)
        XCTAssertNotNil(brik[1])
        XCTAssertNotNil(brik[1, UILabel.self])
    }

    func testGetChildWithNameAndWithSimpleBrik() {
        XCTAssertEqual(brik["one"].accessibilityIdentifier, "one")
        XCTAssertTrue(brik["one"] is UILabel)
    }

    func testChildHasUpdatedTextWithSimpleBrik() {
        brik.child(childName: "one", class: UILabel.self) { label in
            label.text = "hello"
        }

        XCTAssertEqual(brik["one", UILabel.self].text, "hello")
        XCTAssertNotEqual(brik["one", UILabel.self].text, "salut")
    }

    func testChildNumberWithBuildIfBrik() {
        let valueBuildIf: Bool = false

        let brikBuildIf = Brik { _ in
            UILabel()
                .tag(1)
                .accessibilityIdentifier("one")

            if valueBuildIf {
                UILabel()
                .tag(5)
                .accessibilityIdentifier("five")
            }

            UILabel()
                .tag(2)
                .accessibilityIdentifier("two")
            UIButton()
                .tag(3)
                .accessibilityIdentifier("three")
        }

        XCTAssertEqual(brikBuildIf.allChildsAdded().count, 4)
        XCTAssertEqual(brikBuildIf.allChilds().count, 5)
    }

    func testChildFiveNameWithBuildIfBrikNotAppear() {
        let valueBuildIf: Bool = false

        let brikBuildIf = Brik { _ in
            UILabel()
                .tag(1)
                .accessibilityIdentifier("one")

            if valueBuildIf {
                UILabel()
                .tag(5)
                .accessibilityIdentifier("five")
            }

            UILabel()
                .tag(2)
                .accessibilityIdentifier("two")
            UIButton()
                .tag(3)
                .accessibilityIdentifier("three")
        }

        XCTAssertFalse(brikBuildIf.isChildNameExists("five"))
    }

    func testChildFiveNameWithBuildIfBrikAppear() {
        let valueBuildIf: Bool = true

        let brikBuildIf = Brik { _ in
            UILabel()
                .tag(1)
                .accessibilityIdentifier("one")

            if valueBuildIf {
                UILabel()
                .tag(5)
                .accessibilityIdentifier("five")
            }

            UILabel()
                .tag(2)
                .accessibilityIdentifier("two")
            UIButton()
                .tag(3)
                .accessibilityIdentifier("three")
        }

        XCTAssertTrue(brikBuildIf.isChildNameExists("five"))
    }

    static var allTests = [
        ("testChildNumberWithSimpleBrik", testChildNumberWithSimpleBrik),
        ("testGetChildWithTagAndWithSimpleBrik", testGetChildWithTagAndWithSimpleBrik),
        ("testChildHasUpdatedTextWithSimpleBrik", testChildHasUpdatedTextWithSimpleBrik),
        ("testChildHasUpdatedTextWithSimpleBrik", testChildHasUpdatedTextWithSimpleBrik),
        ("testChildNumberWithBuildIfBrik", testChildNumberWithBuildIfBrik),
        ("testChildFiveNameWithBuildIfBrikNotAppear", testChildFiveNameWithBuildIfBrikNotAppear),
        ("testChildFiveNameWithBuildIfBrikAppear", testChildFiveNameWithBuildIfBrikAppear)
    ]
}
