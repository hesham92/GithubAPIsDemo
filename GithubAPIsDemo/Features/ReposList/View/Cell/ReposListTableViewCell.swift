import Kingfisher

class ReposListTableViewCell: UITableViewCell {
    // MARK: - Public
    
    // MARK: Constants
    static let cellIdentifier: String = "ReposListTableViewCell"
    static let cellNib: UINib = UINib(nibName: "ReposListTableViewCell", bundle: nil)
    
    // MARK: - Configuration
    func configure(repo: Repo) {
        self.usernameLabel.text = "Name: " + repo.name
        self.descriptionLabel.text = repo.description
        self.licenseLabel.text = "License: " + (repo.license?.name ?? "")
        
        self.descriptionLabel.isHidden = repo.description == nil
        self.licenseLabel.isHidden = repo.license?.name == nil
    }
    
    override func prepareForReuse() {
        usernameLabel.text = ""
        descriptionLabel.text = ""
        licenseLabel.text = ""
    }
    
    // MARK: - Private

    // MARK: - Outlets
    @IBOutlet weak private var usernameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var licenseLabel: UILabel!
}
