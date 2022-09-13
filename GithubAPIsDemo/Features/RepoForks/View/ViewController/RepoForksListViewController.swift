import UIKit

class RepoForksListViewController: UIViewController, LoadingViewShowing, ErrorViewShowing {
    // MARK: - Public
    
    // MARK: - Initializers
    init(viewModel: RepoForksListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RepoForksListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
    }
    
    static func makeViewController(repoInfo: RepoInfo) -> RepoForksListViewController {
        let viewModel = RepoForksListViewModel(repoInfo: repoInfo)
        let viewController = RepoForksListViewController(viewModel: viewModel)
        return viewController
    }
    
    // MARK: - Private
    
    // MARK: - Configuration
    private func setupView() {
        title = "Forks"
        repoForksLListTableView.register(RepoForksListTableViewCell.cellNib, forCellReuseIdentifier: RepoForksListTableViewCell.cellIdentifier)
    }
    
    private func setupBindings() {
        viewModel.forks.bind { [weak self] forks in
            self?.forks = forks
            self?.repoForksLListTableView.reloadData()
        }
        
        viewModel.errorMessage.bind {[weak self] errorMessage in
            self?.showErrorMessage(errorMessage)
        }
        
        viewModel.isLoading.bindAndApply {[weak self] isLoading in
            self?.handleLoading(isLoading: isLoading)
        }
    }
    
    // MARK: - Properties
    private let viewModel: RepoForksListViewModel
    private var forks: [Fork] = []
    
    // MARK: - Outlets
    @IBOutlet weak private var repoForksLListTableView: UITableView!
}

// MARK: - UITableViewDataSource
extension RepoForksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoForksListTableViewCell.cellIdentifier, for: indexPath) as? RepoForksListTableViewCell else { return UITableViewCell() }
        
        cell.configure(fork: forks[indexPath.row])
        
        return cell
    }
}


