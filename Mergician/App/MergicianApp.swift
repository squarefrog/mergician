//
//  Created by Paul Williamson on 05/11/2021.
//

import SwiftUI

@main
struct MergicianApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            Text("Hello world")
        }

        Settings {
            SettingsView()
                .frame(width: 350)
        }
    }
}
