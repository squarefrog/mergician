import Foundation

struct Repository {
    var name: String
    var service: Service = .gitlab
    var accessToken: String
    var url: URL
    var path: URL

    private(set) var id = UUID()
}

extension Repository: Codable { }
extension Repository: Equatable { }
extension Repository: Identifiable { }