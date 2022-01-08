//
//  SearchRepositoryResponse.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct SearchRepositoryResponse: Decodable {
  var items: [Repository]
}

extension SearchRepositoryResponse {
  struct Repository: Decodable {
    var id: Int64
    var fullName: String
    var description: String?
    var stargazersCount: Int = 0
    var language: String?
    var owner: User
  }

  struct User: Decodable {
    var id: Int64
    var login: String
    var avatarUrl: URL
    var htmlUrl: URL
  }
}
