import SwiftUI

struct InfoView: View {
    let mergeRequest: MergeRequest

    var body: some View {
        HStack {
            Comments(count: mergeRequest.commentCount)

            ApprovalsView(mergeRequest: mergeRequest)

            if mergeRequest.status == .blocked {
                MergeErrorView()
            }
        }
    }
}
