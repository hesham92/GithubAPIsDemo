import Foundation

typealias RepoInfo = (username: String, repoName: String)

class RepoForksListViewModel {
    // MARK: - Public
    
    // MARK: - Observerables
    var forks: Observerable<[Fork]> = Observerable([])
    var errorMessage: Observerable<String> = Observerable("")
    var isLoading: Observerable<Bool> = Observerable(true)
    
    // MARK: - Initializer
    init(service: GithubServiceProtocol = GithubService(), repoInfo: RepoInfo){
        self.service = service
        self.repoInfo = repoInfo
    }
    
    // MARK: - View Actions
    func viewDidLoad() {
        fetchData(repoInfo: repoInfo)
    }
    
    // MARK: - Priavte
    
    // MARK: - GithubServiceProtocol
    private func fetchData(repoInfo: RepoInfo) {
        service.fetchRepoForks(repoInfo: repoInfo,  completion: { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading.value = false
            switch(result) {
            case .success(let forks):
                self.forks.value = forks
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        })
    }
    
    // MARK: - Properties
    private let service: GithubServiceProtocol
    private var repoInfo: RepoInfo
}
