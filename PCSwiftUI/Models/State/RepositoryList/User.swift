//
//  User.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct User: Decodable, Hashable, Identifiable {
  var id: String
  var login: String
  var avatarUrl: URL
  var htmlUrl: URL

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

  init(response: SearchRepositoryResponse.User) {
    self.init(
      id: response.id.description,
      login: response.login,
      avatarUrl: response.avatarUrl,
      htmlUrl: response.htmlUrl
    )
  }
}
