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
    
    func testFetchCoachesList_failure() {
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
    
    func testDidSelectUsersAtIndex() {
        //given
        viewModel.users.value = [User.mock(username: "Hesham", avatarUrl: "Https://Test/image.png", numberOfFollowers: nil, numberOfPublicRepos: nil)]
        //when
        viewModel?.didSelectUsersAtIndex(index: 0)
        
        //then
        XCTAssertEqual(viewModel.naviagteToReposScreen.value, "Hesham")
    }
}
