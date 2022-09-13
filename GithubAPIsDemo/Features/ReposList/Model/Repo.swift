import Foundation

struct Repo: Codable, Equatable {
    let name: String
    let description: String?
    let license: License?
}

struct License: Codable {
    let name: String
}
