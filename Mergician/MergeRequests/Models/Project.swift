import Foundation

struct Project: Decodable {
    let id: Int
    let name: String
    let webUrl: URL
    let approvalsBeforeMerge: Int
}
