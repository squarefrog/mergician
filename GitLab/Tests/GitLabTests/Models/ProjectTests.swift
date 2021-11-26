import XCTest
import GitLab

class ProjectTests: XCTestCase {
    func test_Project_CanBeDecoded() throws {
        let data = Fixture.load("project")
        let decoder = JSONDecoder.gitlab

        let project = try decoder.decode(Project.self, from: data)

        XCTAssertEqual(project.id, 10)
        XCTAssertEqual(project.name, "My App")
        XCTAssertEqual(project.webUrl.absoluteString, "https://git.example.site/my-project/ios-app")
        XCTAssertEqual(project.approvalsBeforeMerge, 2)
    }
}
