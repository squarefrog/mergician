import Foundation

final class DataStore: ObservableObject {
    @Published var items: [ViewModel] = []

    func load() {
        items = MergeRequest.exampleData.map(ViewModel.init)
    }
}
