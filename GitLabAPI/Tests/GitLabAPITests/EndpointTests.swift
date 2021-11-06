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
}