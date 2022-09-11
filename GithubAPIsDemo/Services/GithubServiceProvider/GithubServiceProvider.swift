import Foundation

protocol GithubServiceProviderProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ())
}

class GithubServiceProvider: GithubServiceProviderProtocol {
    private var api: HttpServiceProtocol
    private var completionQueue: DispatchQueue
    
    init(api: HttpServiceProtocol = HttpService(), completionQueue: DispatchQueue = .main) {
        self.api = api
        self.completionQueue = completionQueue
    }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        api.request(GithubAPI.getUsers, modelType:  [User].self) {response in
            self.completionQueue.async {
                completion(response)
            }
        }
    }
}
