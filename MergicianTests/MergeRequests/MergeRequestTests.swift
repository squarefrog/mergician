import XCTest
@testable import Mergician

class MergeRequestTests: XCTestCase {
    func test_MergeRequest_CanBeDecoded() throws {
        let data = Fixture.load("merge_requests")
        let decoder = JSONDecoder.default

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
}
