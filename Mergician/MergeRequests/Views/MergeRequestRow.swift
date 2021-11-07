import SwiftUI

struct MergeRequestRow: View {
    var mr: MergeRequest
    var formatter: DateFormatter

    var body: some View {
        HStack {
            Circle()
                .fill(Color.pink)
                .frame(width: 50, height: 50)
                .accessibility(hidden: true)

            VStack(alignment: .leading, spacing: 3) {
                Text(mr.title)
                    .bold()
                    .lineLimit(1)

                HStack(spacing: 12) {
                    Text(mr.author.name)
                    Text(mr.createdAt, formatter: formatter)
                }
                .foregroundColor(.secondary)

                Metadata(
                    commentCount: mr.userNotesCount,
                    approvals: mr.approvals,
                    mergeStatus: mr.mergeStatus
                )
                .foregroundColor(.secondary)
                .font(.caption)
            }
        }
    }
}
