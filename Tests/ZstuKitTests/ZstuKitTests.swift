import XCTest
import PDFKit
@testable import ZstuKit

final class ZstuKitTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual("Hello, World!", "Hello, World!")
    }
    
    func testRegexAreCorrect() async throws {
        let user = ZKSsoUserData("2020316101023", "haha")
        let session = ZKSsoAuthSession(user)
        try await session.login()
        XCTAssert(!session.crypto.isEmpty)
        XCTAssert(!session.execution.isEmpty)
        print(session.crypto, session.execution, separator: "\n")
    }
}
