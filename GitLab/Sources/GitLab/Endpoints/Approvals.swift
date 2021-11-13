import Foundation

public extension Endpoint {
    static func approvals(for projectId: Int) -> Endpoint {
        Endpoint(path: "projects/\(projectId)/approvals")
    }

    static func approvals(for mergeRequestId: Int, in projectId: Int) -> Endpoint {
        Endpoint(path: "projects/\(projectId)/merge_requests/\(mergeRequestId)/approvals")
    }
}
