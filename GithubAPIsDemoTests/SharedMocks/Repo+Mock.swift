@testable import GithubAPIsDemo

extension Repo {
    static func mock(
        name: String = "testRepo",
        description: String? = "testDescription",
        license: License? = License(name: "testLicense")
    ) -> Repo {
        Repo(
            name: name,
            description: description,
            license: license
        )
    }
}
