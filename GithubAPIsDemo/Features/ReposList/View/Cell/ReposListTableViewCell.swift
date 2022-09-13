import Kingfisher

class ReposListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!

    
    func configure(repo: Repo) {
        self.usernameLabel.text = repo.name
        self.descriptionLabel.text = repo.description
        self.licenseLabel.text = repo.license?.name
    }
    
    override func prepareForReuse() {
        usernameLabel.text = ""
        descriptionLabel.text = ""
        licenseLabel.text = ""
    }
    
    // MARK: Constants
    static let cellIdentifier: String = "ReposListTableViewCell"
    static let cellNib: UINib = UINib(nibName: "ReposListTableViewCell", bundle: nil)
}
