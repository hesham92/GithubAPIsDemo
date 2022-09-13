import Foundation

struct Repo: Codable {
    let name: String
    let description: String?
    let license: License?
}

struct License: Codable {
    let name: String
}
