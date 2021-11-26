import Foundation
import GitLab

final class GitLabServiceAdapter: NetworkServiceProviding {
    typealias Identifier = Int

    let service: GitLabServiceProtocol

    private let decoder = JSONDecoder.gitlab

    init(service: GitLabServiceProtocol) {
        self.service = service
    }

    func getProject(from url: URL) async throws -> Project<Identifier> {
        let data = try await service.get(.project(url: url))
        let gitlabProject = try decoder.decode(GitLab.Project.self, from: data)
        return Project(gitlabProject: gitlabProject)
    }

    func getMergeRequests(for projectId: Identifier) async throws -> [MergeRequest] {
        let data = try await service.get(.mergeRequests(for: projectId))
        let gitlabMergeRequests = try decoder.decode([GitLab.MergeRequest].self, from: data)
        return gitlabMergeRequests.map(MergeRequest.init)
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

private extension MergeRequest {
    init(gitlabMergeRequest: GitLab.MergeRequest) {
        self.id = gitlabMergeRequest.iid
        self.title = gitlabMergeRequest.title
        self.author = .init(gitlabAuthor: gitlabMergeRequest.author)
        self.lastUpdated = gitlabMergeRequest.updatedAt
        self.commentCount = gitlabMergeRequest.userNotesCount
        self.status = .init(mergeStatus: gitlabMergeRequest.mergeStatus)
        self.approvals = nil
    }
}

private extension MergeRequest.Author {
    init(gitlabAuthor: GitLab.Author) {
        self.name = gitlabAuthor.name
        self.avatarURL = gitlabAuthor.avatarUrl
    }
}

private extension MergeRequest.Status {
    init(mergeStatus: GitLab.MergeRequest.Status) {
        switch mergeStatus {
        case .unchecked, .checking:
            self = .unknown
        case .canBeMerged:
            self = .ready
        case .cannotBeMerged, .cannotBeMergedRecheck:
            self = .blocked
        }
    }
}
