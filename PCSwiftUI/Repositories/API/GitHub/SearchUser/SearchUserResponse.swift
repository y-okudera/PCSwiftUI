//
//  SearchUserResponse.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Foundation

struct SearchUserResponse: Decodable {
  var incompleteResults: Bool
  var items: [GitHubUser]
}
