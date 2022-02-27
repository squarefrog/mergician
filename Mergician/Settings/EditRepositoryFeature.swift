import ComposableArchitecture
import SwiftUI

struct EditRepositoryState: Equatable {
    var repository: Repository

    @BindableState var name: String
    @BindableState var service: Service
    @BindableState var accessToken: String
    @BindableState var url: String
    @BindableState var path: String

    enum Field: String, Hashable {
        case name, url, path
    }

    init(repository: Repository) {
        self.repository = repository

        name = repository.name
        service = repository.service
        accessToken = repository.accessToken
        url = repository.url?.absoluteString ?? ""
        path = repository.url?.path ?? ""
    }
}

enum EditRepositoryAction: BindableAction, Equatable {
    case binding(BindingAction<EditRepositoryState>)
    case save
    case cancel
    case showPathPicker
}

struct EditRepositoryEnvironment {
}

let editRepositoryReducer = Reducer<
    EditRepositoryState, EditRepositoryAction, EditRepositoryEnvironment
> { state, action, _ in
    switch action {
    case .binding:
        return .none

    case .save:
        let id = state.repository.id
        state.repository = Repository(
            id: id,
            name: state.name,
            service: state.service,
            accessToken: state.accessToken,
            url: URL(string: state.url),
            path: URL(fileURLWithPath: state.path)
        )
        return .none

    case .cancel:
        let repo = state.repository
        state.name = repo.name
        state.accessToken = repo.accessToken
        state.url = repo.url?.absoluteString ?? ""
        state.path = repo.path?.path ?? ""
        return .none

    case .showPathPicker:
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        if panel.runModal() == .OK {
            state.path = panel.url?.path ?? ""
        }
        return .none
    }
}
.binding()
