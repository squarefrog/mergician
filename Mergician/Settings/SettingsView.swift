import SwiftUI

struct SettingsView: View {
    @State private var accessToken: String = ""
    @State private var projectURL: String = ""

    var body: some View {
        Form {
            SecureField("Access Token", text: $accessToken)

            TextField("Project URL", text: $projectURL)

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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .frame(width: 350)
    }
}
