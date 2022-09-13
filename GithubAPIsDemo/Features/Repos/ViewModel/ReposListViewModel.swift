import Foundation

class ReposListViewModel {
    // MARK: - Observerables
    var repos: Observerable<[Repo]> = Observerable([])
    var errorMessage: Observerable<String> = Observerable("")
    var isLoading: Observerable<Bool> = Observerable(true)
    var naviagteToDetailsScreen: Observerable<Void> = Observerable(())
    var username: String
    
    // MARK: - Properties
    private let service: GithubServiceProtocol
    
    // MARK: - Initializer
    init(service: GithubServiceProtocol = GithubService(), username: String){
        self.service = service
        self.username = username
        self.fetchUserRepos(username: username)
    }
    
    // MARK: - Helpers
    private func fetchUserRepos(username: String) {
        service.fetchUserRepos(username: username, completion: { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading.value = false
            switch(result) {
            case .success(let users):
                print(users)
                self.repos.value = users
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        })
    }
    
    func didSelectRepoAtIndex(index: Int) {
        naviagteToDetailsScreen.value = ()
    }
}
