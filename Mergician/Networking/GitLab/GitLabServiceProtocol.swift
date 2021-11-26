import Foundation
import GitLab

protocol GitLabServiceProtocol {
    func get(_ endpoint: Endpoint) async throws -> Data
}

extension GitLabService: GitLabServiceProtocol { }
