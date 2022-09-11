import Foundation

// MARK: - GithubServiceProviderProtocol
protocol GithubServiceProviderProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ())
}

// MARK: - GithubServiceProvider
class GithubServiceProvider: GithubServiceProviderProtocol {
    // MARK: - Private
    private var api: HttpServiceProtocol
    private var completionQueue: DispatchQueue
    
    // MARK: - Public
    init(api: HttpServiceProtocol = HttpService(), completionQueue: DispatchQueue = .main) {
        self.api = api
        self.completionQueue = completionQueue
    }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        api.request(GithubAPI.getUsers, modelType: [User].self) {response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
}
