import Foundation

struct MergeRequest: Decodable, Identifiable {
    let id: Int
    let iid: Int
    let title: String
    let createdAt: Date
    let userNotesCount: Int
    let author: Author
    let mergeStatus: Status
    let webUrl: URL
}

// MARK: - Merge Status

extension MergeRequest {
    enum Status: String, Decodable {
        case unchecked
        case checking
        case canBeMerged = "can_be_merged"
        case cannotBeMerged = "cannot_be_merged"
        case cannotBeMergedRecheck = "cannot_be_merged_recheck"
    }
}
