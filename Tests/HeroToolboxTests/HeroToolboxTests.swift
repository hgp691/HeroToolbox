import XCTest
@testable import HeroToolbox

final class HeroToolboxTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HeroToolbox().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
