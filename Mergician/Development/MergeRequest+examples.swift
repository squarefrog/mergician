import Foundation

extension MergeRequest {
    static var exampleData: [MergeRequest] {
        let json = Fixture.load("merge_requests")
        let decoder = JSONDecoder.default
        var mergeRequests = try! decoder.decode([MergeRequest].self, from: json)

        for (i, _) in mergeRequests.enumerated() {
            let approval = Approvals(required: mergeRequests.count, remaining: i)
            mergeRequests[i].update(with: approval)
        }

        return mergeRequests
    }
}
