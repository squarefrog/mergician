import XCTest
@testable import GitLabAPI

final class GitLabAPITests: XCTestCase {
    func test_CanBeInitialised() {
        let projectURL = URL(string: "https://git.abc.com/team/project")!
        let session = MockURLSession()

        let sut = GitLabAPI(token: "abc", projectURL: projectURL, urlSession: session)

        XCTAssertNotNil(sut)
    }
}
