import UIKit

class UsersListViewController: UIViewController, LoadingViewShowing, ErrorViewShowing {
    // MARK: - Public
    
    // MARK: - Initializers
    init(viewModel: UsersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "UsersListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
        viewModel.viewDidLoad()
    }
    
    static func makeViewController() -> UsersListViewController {
        let viewModel = UsersListViewModel()
        let viewController = UsersListViewController(viewModel: viewModel)
        return viewController
    }
    
    // MARK: - Private
    
    // MARK: - Configuration
    private func setupView() {
        title = "Users"
        usersListTableView.register(UsersListTableViewCell.cellNib, forCellReuseIdentifier: UsersListTableViewCell.cellIdentifier)
    }
    
    private func setupBindings() {
        viewModel.users.bind { [weak self] users in
            self?.users = users
            self?.usersListTableView.reloadData()
        }
        
        viewModel.errorMessage.bind { [weak self] errorMessage in
            self?.showErrorMessage(errorMessage)
        }
        
        viewModel.isLoading.bindAndApply { [weak self] isLoading in
            self?.handleLoading(isLoading: isLoading)
        }
        
        viewModel.naviagteToReposScreen.bind { [weak self] username in
            let viewController = ReposListViewController.makeViewController(username: username)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - Properties
    private let viewModel: UsersListViewModel
    private var users: [User] = []
    
    // MARK: - Outlets
    @IBOutlet weak private var usersListTableView: UITableView!
}

// MARK: - UITableViewDataSource
extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersListTableViewCell.cellIdentifier, for: indexPath) as? UsersListTableViewCell else { return UITableViewCell() }
        
        cell.configure(user: users[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectUsersAtIndex(index: indexPath.row)
    }
}
