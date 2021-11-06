import Foundation

enum GitLabError: Error {
    case invalidProjectURL
}

public struct GitLabAPI {
    private let token: String
    private let session: URLSessionProtocol
    private let components: URLComponents

    public init(token: String, projectURL: URL, urlSession: URLSessionProtocol = URLSession.shared) throws {
        self.token = token
        self.components = try Self.makeURLComponents(from: projectURL)
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
    private static func makeURLComponents(from url: URL) throws -> URLComponents {
        var components = URLComponents()

        components.scheme = url.scheme
        components.host = url.host
        components.port = url.port
        components.path = "/api/v4/"

        guard components.url != nil else {
            throw GitLabError.invalidProjectURL
        }

        return components
    }

    private func makeRequest(for endpoint: Endpoint) -> URLRequest {
        var components = self.components
        components.path.append(contentsOf: endpoint.path)

        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }

        var request = URLRequest(url: components.url!)
        request.addValue(token, forHTTPHeaderField: "PRIVATE-TOKEN")
        return request
    }
}
