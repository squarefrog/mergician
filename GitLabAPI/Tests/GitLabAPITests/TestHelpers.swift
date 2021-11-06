import Foundation
import GitLabAPI

func makeAPI(with session: URLSessionProtocol) throws -> GitLabAPI {
    let projectURL = URL(string: "https://git.abc.com/team/project")!
    return try GitLabAPI(token: "abc", projectURL: projectURL, urlSession: session)
}
