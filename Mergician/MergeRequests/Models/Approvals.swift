import Foundation

struct Approvals: Decodable {
    let required: Int
    let remaining: Int

    enum CodingKeys: String, CodingKey {
        case required = "approvalsRequired"
        case remaining = "approvalsLeft"
    }
}
