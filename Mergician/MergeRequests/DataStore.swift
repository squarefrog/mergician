import Foundation

final class DataStore: ObservableObject {
    @Published var items: [MergeRequest] = []

    func load() {
        items = MergeRequest.exampleData
    }
}
