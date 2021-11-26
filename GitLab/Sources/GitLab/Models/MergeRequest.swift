import Foundation

public struct MergeRequest: Decodable, Identifiable {
    public let id: Int
    public let iid: Int
    public let title: String
    public let createdAt: Date
    public let userNotesCount: Int
    public let author: Author
    public let mergeStatus: Status
    public let webUrl: URL
    public private(set) var approvals: Approvals?

    public mutating func update(with approvals: Approvals) {
        self.approvals = approvals
    }
}

// MARK: - Merge Status

extension MergeRequest {
    public enum Status: String, Decodable {
        case unchecked
        case checking
        case canBeMerged = "can_be_merged"
        case cannotBeMerged = "cannot_be_merged"
        case cannotBeMergedRecheck = "cannot_be_merged_recheck"
    }
}
