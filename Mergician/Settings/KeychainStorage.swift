import Foundation
import AppKit
import SwiftUI

@propertyWrapper
struct KeychainStorage: DynamicProperty {
    var wrappedValue: String {
        get {
            value
        }
        nonmutating set {
            store(newValue)
            value = newValue
        }
    }

    @State private var value = ""
    private let account: String
    private var searchQuery: [CFString: Any] {
        [
            kSecAttrAccount: account,
            kSecAttrService: Bundle.main.bundleIdentifier ?? "",
            kSecClass: kSecClassGenericPassword
        ]
    }

    init(_ account: String) {
        self.account = account
        _value = State(wrappedValue: loadValue())
    }

    private func store(_ value: String) {
        let attributes: [CFString: Any] = [
            kSecValueData: Data(value.utf8)
        ]

        var status = SecItemUpdate(
            searchQuery as CFDictionary,
            attributes as CFDictionary
        )

        if status == errSecItemNotFound {
            // Item doesn't exist, so add it.
            let query = searchQuery.merging(attributes, uniquingKeysWith: { $1 })
            status = SecItemAdd(query as CFDictionary, nil)
        }

        guard status == errSecSuccess else {
            print("Error storing keychain value: \(status)")
            return
        }
    }

    private func loadValue() -> String {
        var query = searchQuery
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecReturnData] = true

        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )

        guard status == errSecSuccess else {
            print("Error retrieving keychain value: \(status)")
            return ""
        }

        guard let data = itemCopy as? Data else {
            print("Invalid keychain value")
            return ""
        }

        return String(data: data, encoding: .utf8) ?? ""
    }
}
