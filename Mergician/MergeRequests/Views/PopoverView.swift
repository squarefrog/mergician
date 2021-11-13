import SwiftUI

struct PopoverView: View {
    @StateObject private var dataStore = DataStore()

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button(action: refresh) {
                    Image(systemName: "arrow.clockwise")
                }

                Button(action: settings) {
                    Image(systemName: "gear")
                }
            }
            .padding(.trailing)
            .padding(.bottom, 5)

            Divider()

            MergeRequestList(dataStore: dataStore)

            Divider()

            Button(action: quit) {
                Text("Quit")
            }
            .padding(.top, 5)
        }
        .padding(.vertical)
    }

    private func refresh() {
        dataStore.load()
    }

    private func settings() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
    }

    private func quit() {
        NSApplication.shared.terminate(nil)
    }
}

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView()
    }
}
