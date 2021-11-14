import SwiftUI

struct MergeRequestList: View {
    @ObservedObject var dataStore: DataStore

    var body: some View {
        List(dataStore.items) { mergeRequest in
            MergeRequestRow(mergeRequest: mergeRequest)
        }
        .onAppear {
            dataStore.load()
        }
    }
}

struct MergeRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        MergeRequestList(dataStore: .init())
    }
}
