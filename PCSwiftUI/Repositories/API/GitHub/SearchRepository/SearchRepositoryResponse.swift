//
//  SearchRepositoryResponse.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct SearchRepositoryResponse: Decodable {
  var items: [GitHubRepository]
}
