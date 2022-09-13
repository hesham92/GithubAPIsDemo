import UIKit

class UsersListViewController: UIViewController, LoadingViewShowing, ErrorViewShowing {
    // MARK: - Outlets
    @IBOutlet weak private var usersListTableView: UITableView!
    
    // MARK: - Properties
    private let viewModel: UsersListViewModel
    var users: [User] = []
    
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
    }
    
    static func makeViewController() -> UsersListViewController {
        let viewModel = UsersListViewModel()
        let viewController = UsersListViewController(viewModel: viewModel)
        return viewController
    }
    
    // MARK: - Private
    private func setupView() {
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
        
        viewModel.isLoading.bind { [weak self] isLoading in
            self?.handleLoading(isLoading: isLoading)
        }
        
        viewModel.naviagteToReposScreen.bind { [weak self] username in
            let viewController = ReposListViewController.makeViewController(username: username)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
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
