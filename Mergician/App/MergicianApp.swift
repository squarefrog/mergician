import SwiftUI

@main
struct MergicianApp: App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var preferences = Preferences()

    var body: some Scene {
        #if DEBUG
        WindowGroup {
            RepoListView(store: Store(initialValue: .init(), reducer: repoReducer))
        }
        #endif

        Settings {
            RepoListView(store: Store(initialValue: .init(), reducer: repoReducer))
                .frame(width: 350)
                .environmentObject(preferences)
        }
    }
}
