import Foundation
import SwiftUI

final class Preferences: ObservableObject {
    @KeychainStorage("token") var accessToken
    @AppStorage("projectURL") var projectURL: String = ""
    @AppStorage("folderPath") var folderPath: String = ""
}
