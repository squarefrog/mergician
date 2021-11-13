import Foundation

public extension Endpoint {
    static func project(url: URL) -> Endpoint {
        let query = URLQueryItem(name: "web_url", value: url.absoluteString)
        return Endpoint(path: "projects", queryItems: [query])
    }
}
