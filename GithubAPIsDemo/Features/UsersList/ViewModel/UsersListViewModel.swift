import Foundation

class UsersListViewModel {
    // MARK: - Public
    
    // MARK: - Observerables
    var users: Observerable<[User]> = Observerable([])
    var errorMessage: Observerable<String> = Observerable("")
    var isLoading: Observerable<Bool> = Observerable(true)
    var naviagteToReposScreen: Observerable<String> = Observerable("")
    
    // MARK: - Initializer
    init(service: GithubServiceProtocol = GithubService()){
        self.service = service
    }
    
    // MARK: - View Actions
    func didSelectUserAtIndex(index: Int) {
        naviagteToReposScreen.value = users.value[index].username
    }
    
    func viewDidLoad() {
        fetchUsers()
    }
    
    // MARK: - Private
    
    // MARK: - GithubServiceProtocol
    private func fetchUsers() {
        service.fetchUsers(completion: { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading.value = false
            switch(result) {
            case .success(let users):
                self.users.value = users
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        })
    }
    
    // MARK: - Properties
    private let service: GithubServiceProtocol
}
