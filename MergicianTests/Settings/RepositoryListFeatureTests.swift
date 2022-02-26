import ComposableArchitecture
import XCTest

@testable import Mergician

final class RepositoryListFeatureTests: XCTestCase {
    var testRepositories: [Repository] = [
        Repository(id: UUID.testing())
    ]

    func test_AddNew_AddsThenSelectsRepository() throws {
        let repo = try XCTUnwrap(testRepositories.first)
        let store = TestStore(
            initialState: RepositoryListState(),
            reducer: repositoryListReducer,
            environment: RepositoryListEnvironment(uuid: UUID.testing)
        )

        store.send(.addNew) { state in
            state.repositories.append(repo)
        }

        store.receive(.select(repo.id)) { state in
            state.selected = repo.id
        }
    }

    func test_Select() throws {
        let repo = try XCTUnwrap(testRepositories.first)
        let store = TestStore(
            initialState: RepositoryListState(repositories: testRepositories),
            reducer: repositoryListReducer,
            environment: RepositoryListEnvironment(uuid: UUID.testing))

        store.send(.select(repo.id)) { state in
            state.selected = repo.id
        }
    }

    func test_Rename() throws {
        let name = "new-name"
        let repo = try XCTUnwrap(testRepositories.first)

        let store = TestStore(
            initialState: RepositoryListState(
                repositories: testRepositories,
                selected: UUID.testing()
            ),
            reducer: repositoryListReducer,
            environment: RepositoryListEnvironment(uuid: UUID.testing))

        store.send(.rename(name)) { state in
            var renamedRepo = Repository(id: repo.id)
            renamedRepo.name = name
            state.repositories = [renamedRepo]
        }
    }

    func test_Delete_RemovesSelectedRepo() throws {
        let repo = try XCTUnwrap(testRepositories.first)
        let store = TestStore(
            initialState: RepositoryListState(
                repositories: testRepositories,
                selected: repo.id
            ),
            reducer: repositoryListReducer,
            environment: RepositoryListEnvironment(uuid: UUID.testing))

        store.send(.delete) { state in
            state.selected = nil
            state.repositories.removeFirst()
        }
    }

    func test_Delete_DoesNothingWithNoSelection() throws {
        let store = TestStore(
            initialState: RepositoryListState(repositories: testRepositories),
            reducer: repositoryListReducer,
            environment: RepositoryListEnvironment(uuid: UUID.testing))

        store.send(.delete)
    }
}
