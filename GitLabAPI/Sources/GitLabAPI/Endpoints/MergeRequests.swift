import Foundation

public extension Endpoint {
    static func mergeRequests(for projectId: Int) -> Endpoint {
        Endpoint(path: "projects/\(projectId)/merge_requests")
    }
}
