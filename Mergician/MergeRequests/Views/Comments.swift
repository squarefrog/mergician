import SwiftUI

struct Comments: View {
    let count: Int

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "text.bubble.fill")
            Text("\(count)")
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("\(count) comments"))
    }
}
