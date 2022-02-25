import Foundation

struct Repository {
    private(set) var id: UUID

    var name: String = "Untitled"
    var service: Service = .gitlab
    var accessToken: String = ""
    var url: URL?
    var path: URL?
}

extension Repository: Hashable {
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Repository: Codable { }
extension Repository: Equatable { }
extension Repository: Identifiable { }
