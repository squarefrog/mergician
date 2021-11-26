import Foundation
import GitLab

final class GitLabServiceAdapter: NetworkServiceProviding {
    typealias Identifier = Int

    let service: GitLabServiceProtocol

    init(service: GitLabServiceProtocol) {
        self.service = service
    }

    func getProject(from url: URL) async throws -> Project<Identifier> {
        let data = try await service.get(.project(url: url))
        let decoder = JSONDecoder.gitlab
        let gitlabProject = try decoder.decode(GitLab.Project.self, from: data)
        return Project(gitlabProject: gitlabProject)
    }
}

// MARK: - Constructor Helpers

private extension Project where Identifier == Int {
    init(gitlabProject: GitLab.Project) {
        self.id = gitlabProject.id
        self.name = gitlabProject.name
        self.url = gitlabProject.webUrl
        self.requiredApprovals = gitlabProject.approvalsBeforeMerge
    }
}
