import Foundation

struct AppState {
    var repos = [Repository]()
}

enum AppAction {
    case repo(RepoAction)
}
