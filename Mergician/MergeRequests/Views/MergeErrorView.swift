import SwiftUI

struct MergeErrorView: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(.red)
            .accessibilityLabel("Cannot be merged")
    }
}
