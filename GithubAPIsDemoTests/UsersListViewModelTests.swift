import XCTest
@testable import GithubAPIsDemo

class UsersListViewModelTests: XCTestCase {
    var viewModel: UsersListViewModel?
    
    override func setUpWithError() throws {
        viewModel = UsersListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testX() {
        viewModel?.viewDidLoad()
        XCTAssertEqual(viewModel?.users.value, [])
    }
}
