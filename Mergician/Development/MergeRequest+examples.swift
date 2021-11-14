import Foundation

extension MergeRequest {
    static var exampleData: [MergeRequest] {
        [
            MergeRequest(
                id: 0,
                title: "This is an example Merge Request",
                author: Author(name: "Rusty Shackleford"),
                lastUpdated: Date(timeIntervalSince1970: 1636832619),
                commentCount: 2,
                status: .unknown,
                approvals: Approvals(required: 2, received: 0)
            ),

            MergeRequest(
                id: 1,
                title: "This is another example Merge Request",
                author: Author(name: "Dale Gribble"),
                lastUpdated: Date(timeIntervalSince1970: 1636746219),
                commentCount: 26,
                status: .blocked,
                approvals: Approvals(required: 2, received: 1)
            ),

            MergeRequest(
                id: 2,
                title: "This is third example Merge Request",
                author: Author(name: "Hank Hill"),
                lastUpdated: Date(timeIntervalSince1970: 1636659819),
                commentCount: 0,
                status: .ready,
                approvals: Approvals(required: 2, received: 2)
            )
        ]
    }
}

private extension MergeRequest.Author {
    init(name: String) {
        self.name = name
        self.avatarURL = URL(string: "http://via.placeholder.com/64x64")!
    }
}
