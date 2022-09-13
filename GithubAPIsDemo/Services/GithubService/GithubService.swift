import Foundation

// MARK: - GithubServiceProviderProtocol
protocol GithubServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ())
    func fetchUser(username: String, completion: @escaping (Result<User, Error>) -> ())
    func fetchUserRepos(username: String, completion: @escaping (Result<[Repo], Error>) -> ())
    func fetchRepoForks(username: String, repoName: String, completion: @escaping (Result<[User], Error>) -> ())
}

// MARK: - GithubServiceProvider
class GithubService: GithubServiceProtocol {
    // MARK: - Private
    private var api: HttpServiceProtocol
    private var completionQueue: DispatchQueue
    
    // MARK: - Public
    init(api: HttpServiceProtocol = HttpService(), completionQueue: DispatchQueue = .main) {
        self.api = api
        self.completionQueue = completionQueue
    }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        api.request(GithubEndpoint.getUsers, modelType: [User].self) {response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
    
    func fetchUser(username: String, completion: @escaping (Result<User, Error>) -> ()) {
        api.request(GithubEndpoint.getUser(username: username), modelType: User.self) {response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
    
    func fetchUserRepos(username: String, completion: @escaping (Result<[Repo], Error>) -> ()) {
        api.request(GithubEndpoint.getUserRepos(username: username), modelType: [Repo].self) {response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
    
    func fetchRepoForks(username: String, repoName: String, completion: @escaping (Result<[User], Error>) -> ()) {
        api.request(GithubEndpoint.getRepoForks(username: username, repoName: repoName), modelType: [User].self) {response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
}

