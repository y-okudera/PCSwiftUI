//
//  GitHubUser.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Foundation

struct GitHubUser: Decodable {
  var id: Int64
  var login: String
  var avatarUrl: URL
  var htmlUrl: URL
}
