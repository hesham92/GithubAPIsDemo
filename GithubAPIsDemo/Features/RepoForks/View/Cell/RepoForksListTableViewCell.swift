import Kingfisher

class RepoForksListTableViewCell: UITableViewCell {
    // MARK: - Public

    // MARK: Constants
    static let cellIdentifier: String = "RepoForksListTableViewCell"
    static let cellNib: UINib = UINib(nibName: "RepoForksListTableViewCell", bundle: nil)
    
    
    // MARK: - Configuration
    func configure(fork: Fork) {
        ownerUsernameLabel.text = fork.owner.username
        ownerAvatarImageView.kf.indicatorType = .activity
        ownerAvatarImageView.kf.setImage(with: URL(string: fork.owner.avatarUrl))
    }
    
    override func prepareForReuse() {
        ownerUsernameLabel.text = ""
        ownerAvatarImageView.image = nil
    }
    
    // MARK: - Private

    // MARK: - Outlets
    @IBOutlet weak private var ownerUsernameLabel: UILabel!
    @IBOutlet weak private var ownerAvatarImageView: UIImageView!
}
