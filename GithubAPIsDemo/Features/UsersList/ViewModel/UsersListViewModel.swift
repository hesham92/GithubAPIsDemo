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
        self.fetchData()
    }
    
    // MARK: - View Actions
    func didSelectUsersAtIndex(index: Int) {
        naviagteToReposScreen.value = users.value[index].username
    }
    
    // MARK: - Private
    
    // MARK: - GithubServiceProtocol
    private func fetchData() {
        service.fetchUsers(completion: { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading.value = false
            switch(result) {
            case .success(let users):
                print(users)
                self.users.value = users
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        })
    }
    
    // MARK: - Properties
    private let service: GithubServiceProtocol
}
