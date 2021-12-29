import SwiftUI

@main
struct MergicianApp: App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var preferences = Preferences()

    var body: some Scene {
        #if DEBUG
        WindowGroup {
            PopoverView()
                .environmentObject(preferences)
        }
        #endif

        Settings {
            SettingsView()
                .frame(width: 350)
                .environmentObject(preferences)
        }
    }
}
