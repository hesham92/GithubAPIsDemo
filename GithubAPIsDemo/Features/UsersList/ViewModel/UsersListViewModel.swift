import Foundation

class UsersListViewModel {
    // MARK: - Observerables
    var users: Observerable<[User]> = Observerable([])
    var errorMessage: Observerable<String> = Observerable("")
    var isLoading: Observerable<Bool> = Observerable(true)
    var naviagteToDetailsScreen: Observerable<Void> = Observerable(())
    
    // MARK: - Properties
    private let service: GithubServiceProtocol

    // MARK: - Initializer
    init(service: GithubServiceProtocol = GithubService()){
        self.service = service
        self.fetchData()
    }
    
    // MARK: - Helpers
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
    
    func didSelectUsersAtIndex(index: Int) {
        naviagteToDetailsScreen.value = ()
    }
}

