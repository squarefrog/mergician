import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Preferences

    var body: some View {
        Form {
            SecureField("Access Token", text: $settings.accessToken)

            TextField("Project URL", text: $settings.projectURL)

            HStack {
                TextField("Local Path", text: $settings.folderPath)
                Button(action: chooseFolder) {
                    Text("Choose")
                }
            }
        }

        .padding()
    }

    func chooseFolder() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true

        if panel.runModal() == .OK {
            settings.folderPath = panel.url?.path ?? ""
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .frame(width: 350)
    }
}
