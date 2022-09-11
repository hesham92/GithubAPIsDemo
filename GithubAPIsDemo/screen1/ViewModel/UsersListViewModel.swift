import Foundation
import UIKit

class UsersListViewModel {
    private let service: GithubServiceProviderProtocol
    var users: Observerable<[User]> = Observerable([])
    var errorMessage: Observerable<String?> = Observerable(nil)
    var isLoading: Observerable<Bool> = Observerable(true)
    var naviagteTo: Observerable<UIViewController?> = Observerable(nil)
    
    init(service: GithubServiceProviderProtocol = GithubServiceProvider()){
        self.service = service
        self.fetchData()
    }
    
    func fetchData() {
        service.fetchUsers(completion: { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading.value = false
            switch(result) {
            case .success(let users):
                print(users)
                self.users.value = users
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        })
    }
    
    func configureCell(cell: UsersCellViewProtocol, index: Int) {
        cell.username = users.value[index].username
        cell.userAvatarUrl = users.value[index].avatarUrl
    }
    
    func didSelectUsersAtIndex(index: Int) {
        naviagteTo.value = ReposViewController.makeViewController()
    }
}

