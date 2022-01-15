//
//  UserAggregate.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct UserAggregate: Decodable, Hashable, Identifiable {
  let id: String
  let login: String
  let avatarUrl: URL
  let htmlUrl: URL

  init(
    id: String,
    login: String,
    avatarUrl: URL,
    htmlUrl: URL
  ) {
    self.id = id
    self.login = login
    self.avatarUrl = avatarUrl
    self.htmlUrl = htmlUrl
  }

  init(response: GitHubUser) {
    self.init(
      id: response.id.description,
      login: response.login,
      avatarUrl: response.avatarUrl,
      htmlUrl: response.htmlUrl
    )
  }
}

extension UserAggregate {
  static var mock: Self {
    return Self(
      id: 583231.description,
      login: "octocat",
      avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
      htmlUrl: URL(string: "https://github.com/octocat")!
    )
  }
}
