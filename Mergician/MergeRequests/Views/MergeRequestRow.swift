import SwiftUI

struct MergeRequestRow: View {
    var viewModel: ViewModel

    var body: some View {
        HStack {
            Circle()
                .fill(Color.pink)
                .frame(width: 50, height: 50)
                .accessibility(hidden: true)

            VStack(alignment: .leading, spacing: 3) {
                Text(viewModel.title)
                    .bold()
                    .lineLimit(1)

                HStack(spacing: 12) {
                    Text(viewModel.author)
                    Text(viewModel.date)
                }
                .foregroundColor(.secondary)

                InfoView(viewModel: viewModel)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
    }
}
