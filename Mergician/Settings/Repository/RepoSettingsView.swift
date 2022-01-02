import SwiftUI

struct RepoSettingsView: View {
    @ObservedObject var store: Store<AppState, RepoAction>
    @State private var selection: Repository?

    @available(macOS 12, *)
    @FocusState private var focusedField: Repository?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Repositories")
                    .font(.body.bold())
                    .padding(.horizontal)

                // https://github.com/realm/SwiftLint/issues/3790
                // swiftlint:disable:next unused_closure_parameter
                List($store.value.repos) { $repo in
                    NavigationLink(
                        destination: Text(repo.name),
                        tag: repo,
                        selection: $selection
                    ) {
                        let text = Binding(
                            get: { repo.name },
                            set: { repo.name = $0 }
                        )

                        if #available(macOS 12.0, *) {
                            TextField("Name", text: text)
                                .focused($focusedField, equals: repo)
                        } else {
                            TextField("Name", text: text)
                        }
                    }
                }
            }
            .toolbar {
                Button(action: addNewRepository) {
                    Label("Add Repository", systemImage: "plus")
                }
            }

            EmptyRepoListView(action: addNewRepository)
        }
    }

    private func addNewRepository() {
        let repo = makeRepository()
        store.send(.add(repo))
        select(repo)
    }

    private func select(_ repo: Repository) {
        // Select the repository after a tick of the run loop.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            selection = repo

            if #available(macOS 12, *) {
                focusedField = repo
            }
        }
    }

    private func makeRepository() -> Repository {
        Repository(
            name: "Untitled",
            accessToken: "",
            url: nil,
            path: nil
        )
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoSettingsView(store: Store(initialValue: AppState(), reducer: repoReducer))
    }
}
