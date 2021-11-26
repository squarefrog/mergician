import Foundation

struct Project<Identifier> {
    let id: Identifier
    let name: String
    let url: URL
    let requiredApprovals: Int?
}
