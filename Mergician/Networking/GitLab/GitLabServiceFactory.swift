import Foundation
import GitLab

enum GitLabServiceFactory {
    static func makeService(token: String, projectURL: URL) throws -> NetworkServiceProviding {
        let service = try GitLabService(token: token, projectURL: projectURL, urlSession: URLSession.shared)
        return GitLabServiceAdapter(service: service)
    }
}
