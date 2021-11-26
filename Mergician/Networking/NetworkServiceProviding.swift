import Foundation
import GitLab

protocol NetworkServiceProviding {
    associatedtype Identifier
    func getProject(from url: URL) async throws -> Project<Identifier>
    func getMergeRequests(for projectId: Identifier) async throws -> [MergeRequest]
}
