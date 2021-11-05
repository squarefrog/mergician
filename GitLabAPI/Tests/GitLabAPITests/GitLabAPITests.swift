import XCTest
@testable import GitLabAPI

final class GitLabAPITests: XCTestCase {
    func test_CanBeInitialised() throws {
        let projectURL = URL(string: "https://git.abc.com/team/project")!
        let session = MockURLSession()

        let sut = try GitLabAPI(token: "abc", projectURL: projectURL, urlSession: session)

        XCTAssertNotNil(sut)
    }

    func test_GetCurrentUser_CreatesURLRequest() throws {
        let projectURL = URL(string: "https://git.abc.com/team/project")!
        let session = MockURLSession()
        let sut = try GitLabAPI(token: "abc", projectURL: projectURL, urlSession: session)

        sut.get(.currentUser) { _, _, _ in }

        XCTAssertEqual(session.request?.url?.absoluteString, "https://git.abc.com/api/v4/user")
    }
}
