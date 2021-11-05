import Foundation

enum GitLabError: Error {
    case invalidProjectURL
}

public struct GitLabAPI {
    private let token: String
    private let session: URLSessionProtocol
    private let baseURL: URL

    public init(token: String, projectURL: URL, urlSession: URLSessionProtocol = URLSession.shared) throws {
        self.token = token
        self.baseURL = try Self.makeBaseURL(from: projectURL)
        self.session = urlSession

    }

    public func get(_ endpoint: Endpoint, completion: @escaping DataTaskResult) {
        let url = baseURL.appendingPathComponent(endpoint.path)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

extension GitLabAPI {
    private static func makeBaseURL(from url: URL) throws -> URL {
        var components = URLComponents()

        components.scheme = url.scheme
        components.host = url.host
        components.port = url.port
        components.path = "/api/v4/"

        guard let baseURL = components.url else {
            throw GitLabError.invalidProjectURL
        }

        return baseURL
    }
}
