//
//  GitHubRepository.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Foundation

struct GitHubRepository: Decodable {
  var id: Int64
  var fullName: String
  var description: String?
  var stargazersCount: Int = 0
  var language: String?
  var owner: GitHubUser
}
