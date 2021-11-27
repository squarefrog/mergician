import Foundation

public protocol URLSessionProtocol {
    func fetchData(for request: URLRequest) async throws -> (Data, URLResponse)
}

// While Xcode 13.2 has back-ported async/await to macOS 10.15,
// we don't have access to the new async data task calls, so we
// must create our own.
extension URLSession: URLSessionProtocol {
    public func fetchData(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let data = data, let response = response else {
                    continuation.resume(throwing: NetworkError.invalidResponse)
                    return
                }

                continuation.resume(returning: (data, response))
            }
            .resume()
        }
    }
}
