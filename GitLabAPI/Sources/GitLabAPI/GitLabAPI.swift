import Foundation

public struct GitLabAPI {
    private let token: String
    private let session: URLSessionProtocol

    public init(token: String, projectURL: URL, urlSession: URLSessionProtocol = URLSession.shared) {
        self.token = token
        self.session = urlSession
    }
}
