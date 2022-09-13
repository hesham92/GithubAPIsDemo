import Foundation

// MARK: - GithubServiceProviderProtocol
protocol GithubServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ())
    func fetchUser(username: String, completion: @escaping (Result<User, Error>) -> ())
    func fetchUserRepos(username: String, completion: @escaping (Result<[Repo], Error>) -> ())
    func fetchRepoForks(repoInfo: RepoInfo, completion: @escaping (Result<[Fork], Error>) -> ())
}

// MARK: - GithubServiceProvider
class GithubService: GithubServiceProtocol {
    // MARK: - Public
    
    // MARK: - Initializer
    init(api: HttpServiceProtocol = HttpService(), completionQueue: DispatchQueue = .main) {
        self.api = api
        self.completionQueue = completionQueue
    }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        api.request(GithubEndpoint.getUsers, modelType: [User].self) { response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
    
    func fetchUser(username: String, completion: @escaping (Result<User, Error>) -> ()) {
        api.request(GithubEndpoint.getUser(username: username), modelType: User.self) { response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
    
    func fetchUserRepos(username: String, completion: @escaping (Result<[Repo], Error>) -> ()) {
        api.request(GithubEndpoint.getUserRepos(username: username), modelType: [Repo].self) { response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
    
    func fetchRepoForks(repoInfo: RepoInfo, completion: @escaping (Result<[Fork], Error>) -> ()) {
        api.request(GithubEndpoint.getRepoForks(username: repoInfo.username, repoName: repoInfo.repoName), modelType: [Fork].self) { response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
    
    // MARK: - Private
    private var api: HttpServiceProtocol
    private var completionQueue: DispatchQueue
}
