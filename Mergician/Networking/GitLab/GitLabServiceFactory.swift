import Foundation
import GitLab

enum GitLabServiceFactory {
    static func makeService(token: String, projectURL: URL) throws -> GitLabServiceProtocol {
        try GitLabService(token: token, projectURL: projectURL, urlSession: URLSession.shared)
    }
}
