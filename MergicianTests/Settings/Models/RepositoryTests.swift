@testable import Mergician
import XCTest

class RepositoryTests: XCTestCase {
    func test_Repository_ConfirmsToCodable() throws {
        let repo = Repository(
            name: "Foo",
            accessToken: "Bar",
            url: URL(string: "apple.com")!,
            path: URL(fileURLWithPath: "/dev/null")
        )

        let data = try JSONEncoder().encode(repo)
        let copy = try JSONDecoder().decode(Repository.self, from: data)

        XCTAssertEqual(repo, copy)
    }
}
