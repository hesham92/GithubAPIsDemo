//
//  artTableViewCell.swift
//  NYTimesArticles
//
//  Created by Hesham Mohammed on 28/06/2022.
//

import UIKit
import Kingfisher


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
                userAvatarImageView.kf.setImage(with: URL(string: url))
            }
        }
    }
}
