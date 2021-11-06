import Foundation

extension Project {
    static var project: Project {
        let data = Fixture.load("project")
        let decoder = JSONDecoder.default
        return try! decoder.decode(Project.self, from: data)
    }
}
