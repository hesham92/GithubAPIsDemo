import UIKit

class UsersListViewController: UIViewController, LoadingViewShowing, ErrorViewShowing {
    // MARK: - Outlets
    @IBOutlet weak private var usersListTableView: UITableView!
    
    // MARK: - Properties
    private var viewModel: UsersListViewModel
    
    // MARK: - Initializers
    init(viewModel: UsersListViewModel = UsersListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "UsersViewController", bundle: nil)
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
    
    static func makeViewController() -> UsersListViewController {
        let viewController = UsersListViewController()
        return viewController
    }
    
    // MARK: - Private
    private func setupView() {
        usersListTableView.register(UsersListTableViewCell.cellNib, forCellReuseIdentifier: UsersListTableViewCell.cellIdentifier)
    }
    
    private func setupBindings() {
        viewModel.users.bind { [weak self] _ in
            self?.usersListTableView.reloadData()
        }
        
        viewModel.errorMessage.bind {[weak self] errorMessage in
            self?.showErrorMessage(errorMessage)
        }
        
        viewModel.isLoading.bind {[weak self] isLoading in
            self?.handleLoading(isLoading: isLoading)
        }
        
        viewModel.naviagteTo.bind {[weak self] viewController in
            guard let viewController = viewController else { return }
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersListTableViewCell.cellIdentifier, for: indexPath) as! UsersListTableViewCell
        viewModel.configureCell(cell: cell, index: indexPath.row)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectUsersAtIndex(index: indexPath.row)
    }
}
