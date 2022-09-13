import UIKit

class ReposListViewController: UIViewController, LoadingViewShowing, ErrorViewShowing {
    // MARK: - Public
    
    // MARK: - Initializers
    init(viewModel: ReposListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ReposListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
        
    // MARK: - Configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
    }
    
    static func makeViewController(username: String) -> ReposListViewController {
        let viewModel = ReposListViewModel(username: username)
        let viewController = ReposListViewController(viewModel: viewModel)
        return viewController
    }
    
    // MARK: - Private
    
    // MARK: - Configuration
    private func setupView() {
        title = "Repos"
        reposListTableView.register(ReposListTableViewCell.cellNib, forCellReuseIdentifier: ReposListTableViewCell.cellIdentifier)
    }
    
    private func setupBindings() {
        viewModel.repos.bind { [weak self] repos in
            self?.repos = repos
            self?.reposListTableView.reloadData()
        }
        
        viewModel.errorMessage.bind {[weak self] errorMessage in
            self?.showErrorMessage(errorMessage)
        }
        
        viewModel.isLoading.bindAndApply {[weak self] isLoading in
            self?.handleLoading(isLoading: isLoading)
        }
        
        viewModel.naviagteToRepoForksScreen.bind { [weak self] repoInfo in
            let viewController = RepoForksListViewController.makeViewController(repoInfo: repoInfo)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - Properties
    private let viewModel: ReposListViewModel
    private var repos: [Repo] = []
    
    // MARK: - Outlets
    @IBOutlet weak private var reposListTableView: UITableView!
}

// MARK: - UITableViewDataSource
extension ReposListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReposListTableViewCell.cellIdentifier, for: indexPath) as? ReposListTableViewCell else { return UITableViewCell() }
        
        cell.configure(repo: repos[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ReposListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRepoAtIndex(index: indexPath.row)
    }
}



