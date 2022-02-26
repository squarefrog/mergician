import ComposableArchitecture
import SwiftUI

struct RepositoryListState: Equatable {
    var repositories: [Repository] = []
    @BindableState var selected: Repository?
}

enum RepositoryListAction: BindableAction, Equatable {
    case binding(BindingAction<RepositoryListState>)
    case addNew
    case select(Repository)
    case delete
}

struct RepositoryListEnvironment {
    var uuid: () -> UUID
}

let repositoryListReducer = Reducer<
    RepositoryListState,
    RepositoryListAction,
    RepositoryListEnvironment
> { state, action, environment in
    switch action {
    case .binding:
        return .none

    case .addNew:
        let repository = Repository(id: environment.uuid())
        state.repositories.append(repository)
        return Effect(value: .select(repository))

    case .select(let repository):
        state.selected = repository
        return .none

    case .delete:
        if let selected = state.selected {
            state.selected = nil
            state.repositories.removeAll { $0 == selected }
        }
        return .none
    }
}
