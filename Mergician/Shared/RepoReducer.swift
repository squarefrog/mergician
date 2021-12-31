import Foundation

func repoReducer(state: inout AppState, action: RepoAction) {
    switch action {
    case .add(let repository):
        state.repos.append(repository)

    case .update(let repository):
        if let index = state.repos.index(of: repository) {
            state.repos[index] = repository
        }

    case .delete(let repository):
        if let index = state.repos.index(of: repository) {
            state.repos.remove(at: index)
        }
    }
}

enum RepoAction {
    case add(Repository)
    case update(Repository)
    case delete(Repository)
}
