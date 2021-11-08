import SwiftUI

struct InfoView: View {
    let viewModel: ViewModel

    var body: some View {
        HStack {
            Comments(count: viewModel.commentCount)

            ApprovalsView(viewModel: viewModel)

            if viewModel.showMergeError {
                MergeErrorView()
            }
        }
    }
}
