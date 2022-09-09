import UIKit

class UsersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    static func makeViewController() -> UsersViewController {
        let viewControoler = UsersViewController()
        return viewControoler
    }
}
