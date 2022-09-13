@testable import GithubAPIsDemo

extension User {
    static func mock(
        username: String = "Tester",
        avatarUrl: String = "https://avatars.githubusercontent.com/u/431924?v=4",
        numberOfFollowers: Int? = 1,
        numberOfPublicRepos: Int? = 2
    ) -> User {
        User(
            username: username,
            avatarUrl: avatarUrl,
            numberOfFollowers: numberOfFollowers,
            numberOfPublicRepos: numberOfPublicRepos
        )
    }
}
