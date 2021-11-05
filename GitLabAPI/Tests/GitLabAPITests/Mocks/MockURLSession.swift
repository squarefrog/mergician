import Foundation
import GitLabAPI

final class MockURLSession: URLSessionProtocol {
    var request: URLRequest?
    var statusCode = 200

    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse) {
        self.request = request
        return (Data(), URLResponse())
    }
}
