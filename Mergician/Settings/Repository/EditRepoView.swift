import SwiftUI

struct EditRepoView: View {
    let repo: Repository
    let update: ((Repository) -> Void)

    @State private var accessToken: String
    @State private var projectURL: String
    @State private var localURL: String

    init(repo: Repository, update: @escaping ((Repository) -> Void)) {
        self.repo = repo
        self.update = update

        _accessToken = State(wrappedValue: repo.accessToken)
        _projectURL = State(wrappedValue: repo.url?.absoluteString ?? "")
        _localURL = State(wrappedValue: repo.path?.absoluteString ?? "")
    }

    var body: some View {
        Form {
            SecureField("Access Token", text: $accessToken)

            TextField("Project URL", text: $projectURL)

            HStack {
                TextField("Local Path", text: $localURL)
                Button(action: chooseFolder) {
                    Text("Choose")
                }
            }

            HStack {
                Button("Cancel", action: cancel)
                Button("Save", action: save)
            }
        }
        .frame(height: 100)
        .padding()
    }

    private func chooseFolder() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true

        if panel.runModal() == .OK {
            localURL = panel.url?.path ?? ""
        }
    }

    private func cancel() {
        accessToken = repo.accessToken
        projectURL = repo.url?.absoluteString ?? ""
        localURL = repo.path?.absoluteString ?? ""
    }

    private func save() {
        var repo = self.repo
        repo.accessToken = accessToken
        repo.url = URL(string: projectURL)
        repo.path = URL(fileURLWithPath: localURL)
        update(repo)
    }
}

struct EditRepoView_Previews: PreviewProvider {
    static let repo = Repository(name: "My Repo", accessToken: "")

    static var previews: some View {
        EditRepoView(repo: repo, update: { _ in })
            .frame(width: 350)
    }
}
