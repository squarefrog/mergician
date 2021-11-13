import Foundation

public struct Author: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let avatarUrl: URL
}
