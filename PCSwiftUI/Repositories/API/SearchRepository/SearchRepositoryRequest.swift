//
//  SearchRepositoryRequest.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation
import Request

struct SearchRepositoryRequest: APIRequestable {
  typealias Response = SearchRepositoryResponse

  private let searchQuery: String
  private let page: Int

  init(searchQuery: String, page: Int = 1) {
    self.searchQuery = searchQuery
    self.page = page
  }

  var path: String {
    return "/search/repositories"
  }

  var method: MethodType {
    return .get
  }

  var queryItems: [URLQueryItem]? {
    return [
      .init(name: "q", value: searchQuery),
      .init(name: "order", value: "desc"),
      .init(name: "per_page", value: "20"),
      .init(name: "page", value: page.description),
    ]
  }
}
