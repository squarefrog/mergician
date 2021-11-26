import XCTest
import GitLab

class MergeRequestTests: XCTestCase {
    func test_MergeRequest_CanBeDecoded() throws {
        let data = Fixture.load("merge_requests")
        let decoder = JSONDecoder.gitlab

        let mergeRequests = try decoder.decode([MergeRequest].self, from: data)

        let mr = try XCTUnwrap(mergeRequests.first)

        XCTAssertEqual(mr.id, 26504)
        XCTAssertEqual(mr.iid, 1234)
        XCTAssertEqual(mr.title, "Fix crash when logging out")
        XCTAssertEqual(mr.createdAt.timeIntervalSince1970, 1636021589.99)
        XCTAssertEqual(mr.userNotesCount, 2)
        XCTAssertEqual(mr.mergeStatus, .unchecked)
        XCTAssertEqual(mr.webUrl.absoluteString, "https://example.site/project/repo/-/merge_requests/1234")

        let author = mr.author

        XCTAssertEqual(author.id, 161)
        XCTAssertEqual(author.name, "Rusty Shackleford")
        XCTAssertEqual(author.avatarUrl.absoluteString, "http://via.placeholder.com/64x64")
    }

    func test_MergeRequest_CanBeUpdated_WithApprovals() throws {
        let data = Fixture.load("merge_requests")
        let decoder = JSONDecoder.gitlab
        let mergeRequests = try decoder.decode([MergeRequest].self, from: data)
        var mergeRequest = try XCTUnwrap(mergeRequests.first)
        let approvals = Approvals(required: 2, remaining: 1)

        mergeRequest.update(with: approvals)

        XCTAssertEqual(mergeRequest.approvals?.required, approvals.required)
        XCTAssertEqual(mergeRequest.approvals?.remaining, approvals.remaining)
    }
}
