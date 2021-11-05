import XCTest
@testable import GitLabAPI

final class GitLabAPITests: XCTestCase {
    let session = MockURLSession()

    func test_CanBeInitialised() throws {
        let sut = try makeSUT()

        XCTAssertNotNil(sut)
    }

    func test_GetCurrentUser_CreatesURLRequest() throws {
        let sut = try makeSUT()

        sut.get(.currentUser) { _, _, _ in }

        XCTAssertEqual(session.request?.url?.absoluteString, "https://git.abc.com/api/v4/user")
    }

    // MARK: - Helpers

    func test_Get_AddsPrivateToken() throws {
        let sut = try makeSUT()

        sut.get(.currentUser) { _, _, _ in }

        XCTAssertEqual(session.request?.allHTTPHeaderFields?["PRIVATE-TOKEN"], "abc")
    }

    private func makeSUT() throws -> GitLabAPI {
        let projectURL = URL(string: "https://git.abc.com/team/project")!

        let sut = try GitLabAPI(token: "abc", projectURL: projectURL, urlSession: session)

        return sut
    }
}
