import Foundation
import GitLabAPI

final class MockURLSession: URLSessionProtocol {
    var request: URLRequest?

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        self.request = request
        return URLSession.shared.dataTask(with: request)
    }
}
