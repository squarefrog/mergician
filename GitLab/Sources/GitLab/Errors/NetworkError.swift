import Foundation

public enum NetworkError: Error, Equatable {
    case invalidResponse
    case serverError(Int)
}
