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

    func test_GetMergeRequests_ReturnsDecodedMergeRequests() async throws {
        let service = MockGitLabService()
        let sut = GitLabServiceAdapter(service: service)

        let mergeRequests = try await sut.getMergeRequests(for: 10)

        XCTAssertEqual(mergeRequests.count, 4)
        let mr = try XCTUnwrap(mergeRequests.first)
        XCTAssertEqual(mr.id, 1234)
        XCTAssertEqual(mr.title, "Fix crash when logging out")
        XCTAssertEqual(mr.author.name, "Rusty Shackleford")
        XCTAssertEqual(mr.author.avatarURL.absoluteString, "http://via.placeholder.com/64x64")
        XCTAssertEqual(mr.lastUpdated.iso8601, "2021-11-04T11:24:15Z")
        XCTAssertEqual(mr.commentCount, 2)
        XCTAssertEqual(mr.status, .unknown)
        XCTAssertNil(mr.approvals)
    }
}
