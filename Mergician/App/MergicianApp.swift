import SwiftUI

@main
struct MergicianApp: App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var preferences = Preferences()

    var body: some Scene {
        #if DEBUG
        WindowGroup {
            RepoSettingsView(store: Store(initialValue: .init(), reducer: repoReducer))
        }
        #endif

        Settings {
            SettingsView()
                .frame(width: 350)
                .environmentObject(preferences)
        }
    }
}
