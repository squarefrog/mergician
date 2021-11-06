import XCTest
@testable import GitLabAPI

final class ErrorTests: XCTestCase {
    let session = MockURLSession()

    func test_ServerErrors_AreReturned() async throws {
        let sut = try makeAPI(with: session)
        session.statusCode = 404

        await assertEqualError(try await sut.get(.currentUser), NetworkError.serverError(404))
    }
}
