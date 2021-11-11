import SwiftUI

struct SettingsView: View {
    @State private var accessToken: String = ""
    @State private var projectURL: String = ""
    @State private var folderPath: String = ""

    var body: some View {
        Form {
            SecureField("Access Token", text: $accessToken)

            TextField("Project URL", text: $projectURL)

            HStack {
                TextField("Local Path", text: $folderPath)
                Button(action: chooseFolder) {
                    Text("Choose")
                }
            }

            HStack {
                Spacer()

                Button("Cancel") {
                    print("Cancel")
                }
                .keyboardShortcut(.cancelAction)

                Button("Apply") {
                    print("Apply")
                }
                .keyboardShortcut(.defaultAction)
            }
        }

        .padding()
    }

    func chooseFolder() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true

        if panel.runModal() == .OK {
            folderPath = panel.url?.path ?? ""
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .frame(width: 350)
    }
}
