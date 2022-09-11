import Kingfisher


class UsersListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    // MARK: Constants
    static let cellIdentifier: String = "UsersListTableViewCell"
    static let cellNib: UINib = UINib(nibName: "UsersListTableViewCell", bundle: nil)
    
    func configure(user: User) {
        usernameLabel.text = user.username
        userAvatarImageView.kf.indicatorType = .activity
        userAvatarImageView.kf.setImage(with: URL(string: user.avatarUrl))
    }
}
