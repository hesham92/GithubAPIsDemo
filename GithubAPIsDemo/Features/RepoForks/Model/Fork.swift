import Foundation

struct Fork: Codable, Equatable {
    let owner: Owner
}
struct Owner: Codable {
    let username: String
    let avatarUrl: String
    
    private enum CodingKeys : String, CodingKey {
        case avatarUrl = "avatar_url", username = "login"
    }
}

