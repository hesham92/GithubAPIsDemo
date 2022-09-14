import XCTest
@testable import GithubAPIsDemo

class ReposListViewModelTests: XCTestCase {
    var viewModel: ReposListViewModel!
    var serviceMock: GithubServiceMock!
    
    
    override func setUpWithError() throws {
        serviceMock = GithubServiceMock()
        viewModel = ReposListViewModel(service: serviceMock, username: "testName")
    }
    
    override func tearDownWithError() throws {
        serviceMock = nil
        viewModel = nil
    }
    
    func testFetchRepos_success() {
        //given
        let expectedReposList = [Repo.mock()]
        serviceMock.fetchUserReposCallBlock = { _, completion in
            completion(.success(expectedReposList))
        }
        
        //when
        viewModel?.viewDidLoad()
        
        //then
        XCTAssertTrue(viewModel.repos.value.count > 0)
        XCTAssertTrue(viewModel.isLoading.value == false)
        XCTAssertTrue(viewModel.errorMessage.value == "")
    }
    
    func testFetchRepos_failure() {
        //given
        serviceMock.fetchUserReposCallBlock = { _, completion in
            completion(.failure(MockError()))
        }

        //when
        viewModel?.viewDidLoad()

        //then
        XCTAssertTrue(viewModel.repos.value.count == 0)
        XCTAssertTrue(viewModel.isLoading.value == false)
        XCTAssertTrue(viewModel.errorMessage.value != "")
    }
    
    func testDidSelectReposAtIndex() {
        //given
        viewModel.repos.value = [Repo.mock(name: "testName", description: "testDescription", license: License(name: "testLicense"))]
        //when
        viewModel?.didSelectRepoAtIndex(index: 0)
        
        //then
        XCTAssertEqual(viewModel.naviagteToRepoForksScreen.value.repoName, "testName")
    }
}
