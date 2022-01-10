//
//  Repository.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct Repository: Decodable, Hashable, Identifiable {
  var id: String
  var fullName: String
  var description: String?
  var stargazersCount: Int = 0
  var language: String?
  var owner: User

  init(
    id: String,
    fullName: String,
    description: String?,
    stargazersCount: Int,
    language: String?,
    owner: User
  ) {
    self.id = id
    self.fullName = fullName
    self.description = description
    self.stargazersCount = stargazersCount
    self.language = language
    self.owner = owner
  }

  init(response: SearchRepositoryResponse.Repository) {
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

extension Repository {
  static var mock: Self {
    return Self(
      id: 1_300_192.description,
      fullName: "octocat/Spoon-Knife",
      description: "This repo is for demonstration purposes only.",
      stargazersCount: 10673,
      language: "HTML",
      owner: User(
        id: 583231.description,
        login: "octocat",
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
        htmlUrl: URL(string: "https://github.com/octocat")!
      )
    )
  }
}
