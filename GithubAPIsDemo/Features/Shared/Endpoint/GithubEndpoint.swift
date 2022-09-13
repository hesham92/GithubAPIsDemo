import Foundation

// MARK: - GithubEndpoint
enum GithubEndpoint {
    case getUsers
    case getUser(username: String)
    case getUserRepos(username: String)
    case getRepoForks(username: String, repoName: String)
}

extension GithubEndpoint: Endpoint {
    var baseURL: URL { return URL(string: "https://api.github.com/")! }
    
    var path: String {
        switch self {
        case .getUsers:
            return "users"
        case let .getUser(username):
            return "users/\(username)"
        case let .getUserRepos(username):
            return "users/\(username)/repos"
        case let .getRepoForks(username, repoName):
            return "repos/\(username)/\(repoName)/forks"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getUsers, .getUser, .getUserRepos,.getRepoForks:
            return .get
        }
    }
    
    var jsonParameters: [String: Any] {
        return [:]
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json",
                "Authorization" : "Bearer \(Constants.githubToken.base64Decode())"
        ]
    }
    
    enum Constants {
        static let githubToken = "Z2hwXzh3V0Z3ZkdRYUZHTjZuSW40Y3FmR1NEb05jYzVwYTJ0TkxORQ=="
    }
}
