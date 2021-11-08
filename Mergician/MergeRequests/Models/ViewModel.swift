import Foundation

struct ViewModel: Identifiable {
    private let mergeRequest: MergeRequest

    init(mergeRequest: MergeRequest) {
        self.mergeRequest = mergeRequest
    }

    var id: Int {
        mergeRequest.id
    }

    var title: String {
        mergeRequest.title
    }

    var author: String {
        mergeRequest.author.name
    }

    var avatarURL: URL {
        mergeRequest.author.avatarUrl
    }

    var date: String {
        DateFormatter.relative.string(from: mergeRequest.createdAt)
    }

    var commentCount: Int {
        mergeRequest.userNotesCount
    }

    var approvalStatus: ApprovalStatus {
        guard let approvals = mergeRequest.approvals else {
            return .unknown
        }

        if approvals.remaining == 0 {
            return .approved
        }

        let received = approvals.required - approvals.remaining
        return .awaiting("\(received)/\(approvals.required)")
    }

    var showMergeError: Bool {
        mergeRequest.mergeStatus == .cannotBeMerged ||
        mergeRequest.mergeStatus == .cannotBeMergedRecheck
    }
}

extension ViewModel {
    enum ApprovalStatus {
        case approved
        case awaiting(String)
        case unknown
    }
}
