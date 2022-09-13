import Foundation

class ReposListViewModel {
    // MARK: - Public
    
    // MARK: - Observerables
    var repos: Observerable<[Repo]> = Observerable([])
    var errorMessage: Observerable<String> = Observerable("")
    var isLoading: Observerable<Bool> = Observerable(true)
    var naviagteToRepoForksScreen: Observerable<RepoInfo> = Observerable(("",""))
    
    // MARK: - Initializer
    init(service: GithubServiceProtocol = GithubService(), username: String){
        self.service = service
        self.username = username
    }
    
    // MARK: - View Actions
    func didSelectRepoAtIndex(index: Int) {
        let repoName = repos.value[index].name
        naviagteToRepoForksScreen.value = (username, repoName)
    }
    
    func viewDidLoad() {
        self.fetchUserRepos(username: username)
    }
    
    // MARK: - Private
    
    // MARK: - GithubServiceProtocol
    private func fetchUserRepos(username: String) {
        service.fetchUserRepos(username: username, completion: { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading.value = false
            switch(result) {
            case .success(let users):
                self.repos.value = users
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        })
    }
    
    // MARK: - Properties
    private let service: GithubServiceProtocol
    private var username: String
}
