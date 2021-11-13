import XCTest
@testable import GitLab

class ApprovalsTests: XCTestCase {
    func test_Approvals_CanBeDecoded() throws {
        let data = Fixture.load("approvals")
        let decoder = JSONDecoder.default

        let approvals = try decoder.decode(Approvals.self, from: data)
        XCTAssertEqual(approvals.required, 2)
        XCTAssertEqual(approvals.remaining, 1)
    }
}
