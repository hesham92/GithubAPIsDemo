import UIKit

class ReposViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func makeViewController() -> ReposViewController {
        let viewController = ReposViewController()
        return viewController
    }
}
