import Foundation

enum GithubAPI {
    case getUsers
}

extension GithubAPI: EndpointType {
    var baseURL: URL { return URL(string: "https://api.github.com/")! }

    var path: String {
        switch self {
        case .getUsers:
            return "users"
        }
    }

    var method: HttpMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }

    var jsonParameters: [String: Any] {
            return [:]
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

struct User: Codable {
    let username: String
    let avatarUrl: String
    
    private enum CodingKeys : String, CodingKey {
        case username = "login", avatarUrl = "avatar_url"
    }
}

