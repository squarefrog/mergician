import SwiftUI

struct Metadata: View {
    let commentCount: Int
    let approvals: Approvals?
    let mergeStatus: MergeRequest.Status

    var body: some View {
        HStack {
            Comments(commentCount)

            if let approvals = approvals {
                HStack(spacing: 3) {
                    Image(systemName: "checkmark.circle.fill")
                    Text("\(approvals.remaining)/\(approvals.required)")
                }
            }

            if mergeStatus == .cannotBeMerged {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
        }
    }
}
