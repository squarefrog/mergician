import Foundation

struct MergeRequest: Identifiable {
    let id: Int
    let title: String
    let author: Author
    let lastUpdated: Date
    let commentCount: Int
    let status: Status
    var approvals: Approvals?

    struct Author {
        let name: String
        let avatarURL: URL
    }

    enum Status {
        case ready, blocked, unknown
    }

    struct Approvals {
        let required: Int
        let received: Int
    }
}
