import ComposableArchitecture
import SwiftUI

@main
struct MergicianApp: App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        #if DEBUG
        WindowGroup {
            RepoListView(
                store: Store(
                    initialState: RepositoryListState(),
                    reducer: repositoryListReducer,
                    environment: RepositoryListEnvironment(uuid: { UUID() })
                )
            )
        }
        #endif

        Settings {
            RepoListView(
                store: Store(
                    initialState: RepositoryListState(),
                    reducer: repositoryListReducer,
                    environment: RepositoryListEnvironment(uuid: { UUID() })
                )
            )
                .frame(width: 350)
        }
    }
}
