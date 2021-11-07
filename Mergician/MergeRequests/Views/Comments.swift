import SwiftUI

struct Comments: View {
    private let count: Int

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "text.bubble.fill")
            Text("\(count)")
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("\(count) comments"))
    }

    init(_ count: Int) {
        self.count = count
    }
}
