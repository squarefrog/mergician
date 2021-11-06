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

    public func get(_ endpoint: Endpoint) async throws -> Data {
        let request = makeRequest(for: endpoint)
        let (data, response) = try await session.fetchData(for: request)

        if let http = response as? HTTPURLResponse, http.statusCode > 299 {
            throw NetworkError.serverError(http.statusCode)
        }

        return data
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

    private func makeRequest(for endpoint: Endpoint) -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "PRIVATE-TOKEN")
        return request
    }
}
