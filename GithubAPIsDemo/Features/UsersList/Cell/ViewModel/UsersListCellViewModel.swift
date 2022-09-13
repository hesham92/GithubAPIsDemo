import Foundation

class UsersListCellViewModel {
    // MARK: - Public
    
    // MARK: - Observerables
    var user: Observerable<User>
    
    // MARK: - Initializer
    init(service: GithubServiceProtocol = GithubService(), user: User){
        self.service = service
        self.user = Observerable(user)
        
        fetchData()
    }
    
    // MARK: - Private

    // MARK: - GithubServiceProtocol
    private func fetchData() {
        service.fetchUser(username: user.value.username, completion: { [weak self] (result) in
            guard let self = self else { return }
            switch(result) {
            case .success(let user):
                self.user.value = user
            case .failure(let error):
                print(error) // ignore error
            }
        })
    }
    
    // MARK: - Properties
    private let service: GithubServiceProtocol
}
