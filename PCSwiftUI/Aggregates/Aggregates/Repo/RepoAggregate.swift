//
//  RepoAggregate.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct RepoAggregate: Decodable, Hashable, Identifiable {
  let id: String
  let fullName: String
  let description: String?
  let stargazersCount: Int
  let language: String?
  let owner: UserAggregate

  init(
    id: String,
    fullName: String,
    description: String?,
    stargazersCount: Int,
    language: String?,
    owner: UserAggregate
  ) {
    self.id = id
    self.fullName = fullName
    self.description = description
    self.stargazersCount = stargazersCount
    self.language = language
    self.owner = owner
  }

  init(response: GitHubRepository) {
    self.init(
      id: response.id.description,
      fullName: response.fullName,
      description: response.description,
      stargazersCount: response.stargazersCount,
      language: response.language,
      owner: .init(response: response.owner)
    )
  }
}

// MARK: - Mock
extension RepoAggregate {
  static var mock: Self {
    return Self(
      id: 1_300_192.description,
      fullName: "octocat/Spoon-Knife",
      description: "This repo is for demonstration purposes only.",
      stargazersCount: 10673,
      language: "HTML",
      owner: UserAggregate(
        id: 583231.description,
        login: "octocat",
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
        htmlUrl: URL(string: "https://github.com/octocat")!
      )
    )
  }
}
