import Foundation

enum Fixture {
    static func load(_ resource: String) -> Data {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json") else {
            fatalError("Missing file: \(resource).json")
        }

        return try! Data(contentsOf: url)
    }
}
