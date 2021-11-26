import XCTest
import GitLab
@testable import Mergician

final class GitLabServiceAdapterTests: XCTestCase {
    func test_GetProject_ReturnsDecodedProjectModel() async throws {
        let service = MockGitLabService()
        let url = URL(string: "https://gitlab.com/example")!
        let sut = GitLabServiceAdapter(service: service)

        let project = try await sut.getProject(from: url)

        XCTAssertEqual(project.id, 10)
        XCTAssertEqual(project.name, "My App")
        XCTAssertEqual(project.url.absoluteString, "https://git.example.site/my-project/ios-app")
        XCTAssertEqual(project.requiredApprovals, 2)
    }
}
