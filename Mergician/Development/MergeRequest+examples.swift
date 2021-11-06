import Foundation

extension MergeRequest {
    static var exampleData: [MergeRequest] {
        let json = Fixture.load("merge_requests")
        let decoder = JSONDecoder.default
        return try! decoder.decode([MergeRequest].self, from: json)
    }
}
