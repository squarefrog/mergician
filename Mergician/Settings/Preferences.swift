import Foundation
import SwiftUI

final class Preferences: ObservableObject {
    @Published var accessToken = ""
    @AppStorage("projectURL") var projectURL: String = ""
    @AppStorage("folderPath") var folderPath: String = ""
}
