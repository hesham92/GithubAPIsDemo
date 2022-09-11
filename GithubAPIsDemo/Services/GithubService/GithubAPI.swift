import Foundation

enum GithubAPI {
    case getUsers
    case getUser(username: String)
}

extension GithubAPI: Endpoint {
    var baseURL: URL { return URL(string: "https://api.github.com/")! }

    var path: String {
        switch self {
        case .getUsers:
            return "users"
        case let .getUser(username):
            return "users/\(username)"
        }
    }

    var method: HttpMethod {
        switch self {
        case .getUsers, .getUser:
            return .get
        }
    }

    var jsonParameters: [String: Any] {
            return [:]
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json",
                "Authorization" : "Bearer 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"]
    }
}

struct User: Codable {
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

