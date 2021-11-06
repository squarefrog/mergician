import Foundation

struct Author: Decodable, Identifiable {
    let id: Int
    let name: String
    let avatarUrl: URL
}
