import Foundation

public extension JSONDecoder {
    static var gitlab: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        return decoder
    }
}
