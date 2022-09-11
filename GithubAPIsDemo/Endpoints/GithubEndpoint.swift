import Foundation

enum GithubEndpoint {
    case getUsers
    case getUser(username: String)
}

extension GithubEndpoint: Endpoint {
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
        let token = "Z2hwXzh3V0Z3ZkdRYUZHTjZuSW40Y3FmR1NEb05jYzVwYTJ0TkxORQ=="
        return ["Content-type": "application/json",
                "Authorization" : "Bearer \(token.base64Decode())"
        ]
    }
}

extension String {
    func base64Decode() -> String {
        let encodedData = Data(base64Encoded: self)
        return String(data: encodedData!, encoding: .utf8)!
    }
}
