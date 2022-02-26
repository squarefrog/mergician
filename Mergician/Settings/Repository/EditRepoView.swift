import ComposableArchitecture
import SwiftUI

struct EditRepoView: View {
    let store: Store<EditRepositoryState, EditRepositoryAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Form {
                TextField("Name", text: viewStore.binding(\.$name))

                SecureField("Access Token", text: viewStore.binding(\.$accessToken))

                TextField("Project URL", text: viewStore.binding(\.$url))

                HStack {
                    TextField("Local Path", text: viewStore.binding(\.$path))
                    Button("Choose") {
                        viewStore.send(.showPathPicker)
                    }
                }

                HStack {
                    Button("Cancel") {
                        viewStore.send(.cancel)
                    }
                    Button("Save") {
                        viewStore.send(.save)
                    }
                }
            }
            .frame(height: 100)
            .padding()
        }
    }
}

struct EditRepoView_Previews: PreviewProvider {
    static let repo = Repository(id: UUID(), name: "My Repo", accessToken: "")

    static var previews: some View {
        EditRepoView(
            store: Store(
                initialState: EditRepositoryState(repository: repo),
                reducer: editRepositoryReducer,
                environment: EditRepositoryEnvironment()
            )
        )
            .frame(width: 350)
    }
}
