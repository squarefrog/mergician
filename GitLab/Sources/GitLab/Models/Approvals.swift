import Foundation

public struct Approvals: Decodable {
    public let required: Int
    public let remaining: Int

    public enum CodingKeys: String, CodingKey {
        case required = "approvalsRequired"
        case remaining = "approvalsLeft"
    }
}
