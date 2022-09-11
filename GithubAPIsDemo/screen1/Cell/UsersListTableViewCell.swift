import Kingfisher

// MARK: - UsersCellViewProtocol
protocol UsersCellViewProtocol: AnyObject {
    var username: String { get set }
    var userAvatarUrl: String? { get set }
}

class UsersListTableViewCell: UITableViewCell, UsersCellViewProtocol {
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    // MARK: Constants
    static let cellIdentifier: String = "UsersListTableViewCell"
    static let cellNib: UINib = UINib(nibName: "UsersListTableViewCell", bundle: nil)
    
    var username: String = "" {
        didSet {
            usernameLabel.text = username
        }
    }
    
    var userAvatarUrl: String? {
        didSet {
            if let url = userAvatarUrl {
                userAvatarImageView.kf.indicatorType = .activity
                userAvatarImageView.kf.setImage(with: URL(string: url))
            }
        }
    }
}
