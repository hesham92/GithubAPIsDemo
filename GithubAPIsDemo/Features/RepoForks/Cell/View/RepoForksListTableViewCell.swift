import Kingfisher

class RepoForksListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var ownerUsernameLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    
    func configure(fork: Fork) {
        ownerUsernameLabel.text = fork.owner.username
        ownerAvatarImageView.kf.indicatorType = .activity
        ownerAvatarImageView.kf.setImage(with: URL(string: fork.owner.avatarUrl))
    }
    
    override func prepareForReuse() {
        ownerUsernameLabel.text = ""
        ownerAvatarImageView.image = nil
    }
    
    // MARK: Constants
    static let cellIdentifier: String = "RepoForksListTableViewCell"
    static let cellNib: UINib = UINib(nibName: "RepoForksListTableViewCell", bundle: nil)
}
