import XCTest
@testable import GitLabAPI

final class EndpointTests: XCTestCase {
    let session = MockURLSession()

    func test_Get_AddsPrivateToken() async throws {
        let sut = try makeAPI(with: session)

        _ = try await sut.get(.currentUser)

        XCTAssertEqual(session.request?.allHTTPHeaderFields?["PRIVATE-TOKEN"], "abc")
    }

    func test_GetCurrentUser_CreatesURLRequest() async throws {
        let sut = try makeAPI(with: session)

        _ = try await sut.get(.currentUser)

        XCTAssertEqual(session.request?.url?.absoluteString, "https://git.abc.com/api/v4/user")
    }

    func test_GetProject_CreatesURLRequest() async throws {
        let sut = try makeAPI(with: session)
        let urlString = "https://git.abc.com/team/project"
        let url = URL(string: urlString)!

        _ = try await sut.get(.project(url: url))

        XCTAssertEqual(
            session.request?.url?.absoluteString,
            "https://git.abc.com/api/v4/projects?web_url=\(urlString)"
        )
    }

    func test_GetMergeRequests_CreatesURLRequest() async throws {
        let sut = try makeAPI(with: session)
        let projectId = 10

        _ = try await sut.get(.mergeRequests(for: projectId))

        XCTAssertEqual(
            session.request?.url?.absoluteString,
            "https://git.abc.com/api/v4/projects/\(projectId)/merge_requests"
        )
    }

    func test_GetApprovalsForProject_CreatesURLRequest() async throws {
        let sut = try makeAPI(with: session)
        let projectId = 10

        _ = try await sut.get(.approvals(for: projectId))

        XCTAssertEqual(
            session.request?.url?.absoluteString,
            "https://git.abc.com/api/v4/projects/\(projectId)/approvals"
        )
    }

    func test_GetApprovalsForMergeRequest_CreatesURLRequest() async throws {
        let sut = try makeAPI(with: session)
        let mrId = 1
        let projectId = 10

        _ = try await sut.get(.approvals(for: mrId, in: projectId))

        XCTAssertEqual(
            session.request?.url?.absoluteString,
            "https://git.abc.com/api/v4/projects/\(projectId)/merge_requests/\(mrId)/approvals"
        )
    }
}
