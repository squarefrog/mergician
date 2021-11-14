import SwiftUI

struct MergeRequestRow: View {
    let mergeRequest: MergeRequest

    var body: some View {
        HStack {
            Circle()
                .fill(Color.pink)
                .frame(width: 50, height: 50)
                .accessibility(hidden: true)

            VStack(alignment: .leading, spacing: 3) {
                Text(mergeRequest.title)
                    .bold()
                    .lineLimit(1)

                HStack(spacing: 12) {
                    Text(mergeRequest.author.name)
                    Text(mergeRequest.lastUpdated, formatter: DateFormatter.relative)
                }
                .foregroundColor(.secondary)

                InfoView(mergeRequest: mergeRequest)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
    }
}
