import Foundation
import GitLab
@testable import Mergician

final class MockGitLabService: GitLabServiceProtocol {
    var endpoint: Endpoint?

    func get(_ endpoint: Endpoint) async throws -> Data {
        self.endpoint = endpoint
        return try loadFixture(for: endpoint)
    }

    private func loadFixture(for endpoint: Endpoint) throws -> Data {
        try loadFile(named: "project")
    }

    private func loadFile(named filename: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw FileError.missingFile("\(filename).json")
        }

        return try Data(contentsOf: url)
    }

    enum FileError: Error, LocalizedError {
        case missingFile(String)

        var errorDescription: String? {
            switch self {
            case .missingFile(let filename):
                return "Test bundle does not contain file named \(filename)."
            }
        }
    }
}
