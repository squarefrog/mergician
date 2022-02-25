import SwiftUI

struct RepoListView: View {
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

                List($store.value.repos) { $repo in
                    NavigationLink(
                        destination: EditRepoView(
                            repo: repo,
                            update: {
                                store.send(.update($0))
                            }
                        ),
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
                ToolbarItem(placement: .navigation) {
                    Button(action: toggleSidebar, label: {
                        Image(systemName: "sidebar.leading")
                    })
                }

                ToolbarItem {
                    Button(action: addNewRepository) {
                        Label("Add Repository", systemImage: "plus")
                    }
                }
            }

            EmptyRepoListView(action: addNewRepository)
        }
    }

    private func toggleSidebar() {
        NSApp.keyWindow?
            .firstResponder?
            .tryToPerform(
                #selector(NSSplitViewController.toggleSidebar(_:)),
                with: nil
            )
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
            id: UUID(),
            name: "Untitled",
            accessToken: "",
            url: nil,
            path: nil
        )
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView(store: Store(initialValue: AppState(), reducer: repoReducer))
    }
}
