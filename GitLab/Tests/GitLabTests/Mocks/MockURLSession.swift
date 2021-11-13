import Foundation
import GitLab

final class MockURLSession: URLSessionProtocol {
    var request: URLRequest?
    var statusCode = 200

    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse) {
        self.request = request
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        return (Data(), response as URLResponse)
    }
}
