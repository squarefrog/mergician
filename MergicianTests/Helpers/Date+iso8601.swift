import Foundation

extension Date {
    var iso8601: String {
        if #available(macOS 12.0, *) {
            return self.formatted(.iso8601)
        } else {
            let formatter = ISO8601DateFormatter()
            return formatter.string(from: self)
        }
    }
}
