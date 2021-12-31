import SwiftUI

struct EmptyRepoListView: View {
    let action: (() -> Void)

    var body: some View {
        VStack(spacing: 20) {
            Text("No repositories configured")
                    .foregroundColor(.secondary)
            Button("Add Repository", action: action)
        }
    }
}

struct EmptyRepoView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyRepoListView(action: {})
            .frame(width: 500, height: 400)
    }
}
