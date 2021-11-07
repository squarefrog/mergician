import SwiftUI

struct MergeRequestList: View {
    let mergeRequests = MergeRequest.exampleData

    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()

    var body: some View {
        List {
            ForEach(mergeRequests) { mr in
                MergeRequestRow(mr: mr, formatter: formatter)
            }
        }
    }
}

struct MergeRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        MergeRequestList()
//            .frame(width: 400)
    }
}
