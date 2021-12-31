import Foundation

extension Array where Element == Repository {
    func index(of repository: Repository) -> Int? {
        firstIndex { $0.id == repository.id }
    }
}
