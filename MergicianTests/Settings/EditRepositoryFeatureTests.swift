import ComposableArchitecture
import XCTest

@testable import Mergician

final class EditRepositoryFeatureTests: XCTestCase {
    let repo = Repository(
        id: UUID.testing(),
        name: "Foo",
        accessToken: "Bar",
        url: URL(string: "apple.com")!,
        path: URL(fileURLWithPath: "/dev/null")
    )

    func test_Save() {
        let store = TestStore(
            initialState: EditRepositoryState(repository: repo),
            reducer: editRepositoryReducer,
            environment: EditRepositoryEnvironment()
        )

        let editRepo = makeEditedRepository()
        mutateStore(store, using: editRepo)

        store.send(.save) { state in
            state.repository = editRepo
        }
    }

    func test_Cancel() {
        let store = TestStore(
            initialState: EditRepositoryState(repository: repo),
            reducer: editRepositoryReducer,
            environment: EditRepositoryEnvironment()
        )

        mutateStore(store, using: makeEditedRepository())

        store.send(.cancel) { state in
            state.focusedField = nil
            state.name = self.repo.name
            state.service = self.repo.service
            state.accessToken = self.repo.accessToken
            state.url = self.repo.url!.absoluteString
            state.path = self.repo.path!.path
        }
    }
}

// MARK: - Helpers

extension EditRepositoryFeatureTests {
    private func makeEditedRepository() -> Repository {
        Repository(
            id: UUID.testing(),
            name: "name",
            service: .gitlab,
            accessToken: "access-token",
            url: URL(string: "squarefrog.co.uk")!,
            path: URL(fileURLWithPath: "/")
        )
    }

    typealias Store = TestStore<
        EditRepositoryState,
        EditRepositoryState,
        EditRepositoryAction,
        EditRepositoryAction,
        EditRepositoryEnvironment
    >

    private func mutateStore(_ store: Store, using repository: Repository) {
        store.send(.set(\.$name, repository.name)) {
            $0.name = repository.name
        }
        store.send(.set(\.$accessToken, repository.accessToken)) {
            $0.accessToken = repository.accessToken
        }
        store.send(.set(\.$url, repository.url!.absoluteString)) {
            $0.url = repository.url!.absoluteString
        }
        store.send(.set(\.$path, repository.path!.path)) {
            $0.path = repository.path!.path
        }
    }
}
