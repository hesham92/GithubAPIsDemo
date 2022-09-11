import Kingfisher


class UsersListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var numberOfFollowersLabel: UILabel!
    @IBOutlet weak var numberOfPublicReposLabel: UILabel!
    
    var viewModel: UsersListCellViewModel?
    
    func configure(user: User) {
        viewModel = UsersListCellViewModel(user: user)
        
        viewModel?.user.bindAndApply { [weak self] user in
            self?.usernameLabel.text = "Username: " + user.username
            self?.userAvatarImageView.kf.indicatorType = .activity
            self?.userAvatarImageView.kf.setImage(with: URL(string: user.avatarUrl))
            self?.numberOfFollowersLabel.text = "Followers: " + (user.numberOfFollowers.map({ String($0) }) ?? "")
            self?.numberOfPublicReposLabel.text = "Public repos: " + (user.numberOfPublicRepos.map({ String($0) }) ?? "")
        }
    }
    
    override func prepareForReuse() {
        usernameLabel.text = ""
        userAvatarImageView.image = nil
        numberOfFollowersLabel.text = ""
        numberOfPublicReposLabel.text = ""
    }
    
    // MARK: Constants
    static let cellIdentifier: String = "UsersListTableViewCell"
    static let cellNib: UINib = UINib(nibName: "UsersListTableViewCell", bundle: nil)
}
