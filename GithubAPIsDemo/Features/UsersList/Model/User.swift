import Foundation

struct User: Codable, Equatable {
    let username: String
    let avatarUrl: String
    let numberOfFollowers: Int?
    let numberOfPublicRepos: Int?

    private enum CodingKeys : String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_url"
        case numberOfFollowers = "followers"
        case numberOfPublicRepos = "public_repos"
    }
}



