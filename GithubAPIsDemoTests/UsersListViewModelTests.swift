import XCTest
@testable import GithubAPIsDemo

class UsersListViewModelTests: XCTestCase {
    var viewModel: UsersListViewModel!
    var serviceMock: GithubServiceMock!
    
    
    override func setUpWithError() throws {
        serviceMock = GithubServiceMock()
        viewModel = UsersListViewModel(service: serviceMock)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func getFakeUsers() -> [User] {
        [User(username: "dds", avatarUrl: "sdsddssd", numberOfFollowers: 1, numberOfPublicRepos: 2)]
    }
    
    func testX() {
        let expectedUserList = getFakeUsers()
        serviceMock.fetchUsersCallBlock = { completion in
            completion(.success(expectedUserList))
        }
        
        viewModel?.viewDidLoad()
        
        XCTAssertTrue(viewModel.users.value.count > 0)
        XCTAssertTrue(viewModel.isLoading.value == false)
        XCTAssertTrue(viewModel.errorMessage.value == "")
    }
}
