@testable import Mergician
import XCTest

class RepoReducerTests: XCTestCase {
    func test_RepoReducer_InsertsRepository() throws {
        let store = makeStore()
        let repository = makeRepo()

        store.send(.add(repository))

        XCTAssertEqual(store.value.repos.count, 1)
        XCTAssertEqual(store.value.repos.first, repository)
    }

    func test_RepoReducer_UpdatesRepository() throws {
        let store = makeStore()
        var repository = makeRepo()
        store.send(.add(repository))

        repository.name = "new-name"
        store.send(.update(repository))

        XCTAssertEqual(store.value.repos.count, 1)
        XCTAssertEqual(store.value.repos.first?.name, "new-name")
    }

    func test_RepoReducer_DeletesRepository() throws {
        let store = makeStore()
        let repository = makeRepo()
        store.send(.add(repository))
        XCTAssertEqual(store.value.repos.count, 1)

        store.send(.delete(repository))

        XCTAssertEqual(store.value.repos.count, 0)
    }

    private func makeStore() -> Store<AppState, RepoAction> {
        Store(initialValue: AppState(), reducer: repoReducer)
    }

    private func makeRepo() -> Repository {
        Repository(
            name: "name",
            accessToken: "token",
            url: URL(string: "apple.com"),
            path: URL(fileURLWithPath: "/dev/null")
        )
    }
}
