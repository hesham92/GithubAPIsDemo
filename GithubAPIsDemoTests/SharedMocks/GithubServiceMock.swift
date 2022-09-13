import Foundation
@testable import GithubAPIsDemo

final class GithubServiceMock: GithubServiceProtocol {
    var fetchUsersCallBlock: ((
        _ completion: (Result<[User], Error>) -> Void) -> Void)?
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        fetchUsersCallBlock?(completion)
    }
    
    func fetchUser(username: String, completion: @escaping (Result<User, Error>) -> ()) {
        
    }
    
    func fetchUserRepos(username: String, completion: @escaping (Result<[Repo], Error>) -> ()) {
        
    }
    
    func fetchRepoForks(repoInfo: RepoInfo, completion: @escaping (Result<[Fork], Error>) -> ()) {
        
    }
}
