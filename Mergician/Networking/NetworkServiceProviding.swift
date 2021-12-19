import Foundation
import GitLab

protocol NetworkServiceProviding {
    func getProject(from url: URL) async throws -> Project
    func getMergeRequests(for projectId: Int) async throws -> [MergeRequest]
}
