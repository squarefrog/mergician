import Foundation

public struct Project: Decodable {
    public let id: Int
    public let name: String
    public let webUrl: URL
    public let approvalsBeforeMerge: Int
}
