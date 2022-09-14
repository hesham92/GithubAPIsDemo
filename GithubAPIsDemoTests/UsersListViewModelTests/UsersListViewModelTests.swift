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
        serviceMock = nil
        viewModel = nil
    }
    
    func testFetchUsers_success() {
        //given
        let expectedUsersList = [User.mock()]
        serviceMock.fetchUsersCallBlock = { completion in
            completion(.success(expectedUsersList))
        }
        
        //when
        viewModel?.viewDidLoad()
        
        //then
        XCTAssertTrue(viewModel.users.value.count > 0)
        XCTAssertTrue(viewModel.isLoading.value == false)
        XCTAssertTrue(viewModel.errorMessage.value == "")
    }
    
    func testFetchUsers_failure() {
        //given
        serviceMock.fetchUsersCallBlock = { completion in
            completion(.failure(MockError()))
        }

        //when
        viewModel?.viewDidLoad()

        //then
        XCTAssertTrue(viewModel.users.value.count == 0)
        XCTAssertTrue(viewModel.isLoading.value == false)
        XCTAssertTrue(viewModel.errorMessage.value != "")
    }
    
    func testDidSelectUserAtIndex() {
        //given
        viewModel.users.value = [User.mock(username: "Test1", avatarUrl: "Https://Test/image.png", numberOfFollowers: nil, numberOfPublicRepos: nil), User.mock(username: "Test2", avatarUrl: "Https://Test/image.png", numberOfFollowers: nil, numberOfPublicRepos: nil)]
        
        //when
        viewModel?.didSelectUserAtIndex(index: 1)
        
        //then
        XCTAssertEqual(viewModel.naviagteToReposScreen.value, "Test2")
    }
}
