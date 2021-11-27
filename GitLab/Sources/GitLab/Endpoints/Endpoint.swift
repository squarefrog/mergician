import Foundation

// MARK: - Definition

public struct Endpoint {
    public var path: String
    public var queryItems = [URLQueryItem]()
}

// MARK: - Approvals

public extension Endpoint {
    /// Get approval rules for a given `projectId`.
    static func approvals(for projectId: Int) -> Endpoint {
        Endpoint(path: "projects/\(projectId)/approvals")
    }

    /// Get current approvals for a given `mergeRequestId` within a `projectId`.
    static func approvals(for mergeRequestId: Int, in projectId: Int) -> Endpoint {
        Endpoint(path: "projects/\(projectId)/merge_requests/\(mergeRequestId)/approvals")
    }
}

// MARK: - Current User

public extension Endpoint {
    /// Get the current user.
    static var currentUser = Endpoint(path: "user")
}

// MARK: - Merge Requests

public extension Endpoint {
    /// Get all merge requests for a given `projectId`.
    static func mergeRequests(for projectId: Int) -> Endpoint {
        let query = URLQueryItem(name: "state", value: "opened")
        return Endpoint(path: "projects/\(projectId)/merge_requests", queryItems: [query])
    }
}

// MARK: - Project

public extension Endpoint {
    /// Get the project model for a given public web URL.
    static func project(url: URL) -> Endpoint {
        let query = URLQueryItem(name: "web_url", value: url.absoluteString)
        return Endpoint(path: "projects", queryItems: [query])
    }
}
