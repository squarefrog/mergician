import XCTest
import GitLab

func makeAPI(with session: URLSessionProtocol) throws -> GitLabService {
    let projectURL = URL(string: "https://git.abc.com/team/project")!
    return try GitLabService(token: "abc", projectURL: projectURL, urlSession: session)
}

extension XCTest {
    func assertEqualError<T, E: Equatable>(
        _ expression: @autoclosure () async throws -> T,
        _ expected: E,
        file: StaticString = #filePath,
        line: UInt = #line
    ) async {
        do {
            _ = try await expression()
            XCTFail("did not throw an error", file: file, line: line)
        } catch let error as E {
            XCTAssertEqual(error, expected, file: file, line: line)
        } catch {
            XCTFail("unknown error \(error)", file: file, line: line)
        }
    }
}

enum Fixture {
    static func load(_ resource: String) -> Data {
        guard let url = Bundle.module.url(forResource: resource, withExtension: "json") else {
            fatalError("Missing file: \(resource).json")
        }

        // swiftlint:disable:next force_try
        return try! Data(contentsOf: url)
    }
}
