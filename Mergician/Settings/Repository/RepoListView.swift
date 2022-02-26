import ComposableArchitecture
import SwiftUI

struct RepoListView: View {
    let store: Store<RepositoryListState, RepositoryListAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack(alignment: .leading) {
                    Text("Repositories")
                        .font(.body.bold())
                        .padding(.horizontal)

                    List(viewStore.repositories) { repo in
                        NavigationLink(
                            destination: EditRepoView(
                                store: Store(
                                    initialState: EditRepositoryState(repository: repo),
                                    reducer: editRepositoryReducer,
                                    environment: EditRepositoryEnvironment()
                                )
                            ),
                            tag: repo.id,
                            selection: viewStore.binding(
                                get: \.selected,
                                send: RepositoryListAction.select
                            )
                        ) {
                            Text(repo.name)
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
                        Button {
                            viewStore.send(.addNew)
                        } label: {
                            Label("Add Repository", systemImage: "plus")
                        }
                    }
                }

                EmptyRepoListView {
                    viewStore.send(.addNew)
                }
            }
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
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView(
            store: Store(
                initialState: RepositoryListState(),
                reducer: repositoryListReducer,
                environment: RepositoryListEnvironment(uuid: { UUID() })
            )
        )
    }
}
