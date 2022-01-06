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

  private let searchWords: String
  init(searchWords: String) {
    self.searchWords = searchWords
  }

  var path: String {
    return "/search/repositories"
  }

  var method: MethodType {
    return .get
  }

  var queryItems: [URLQueryItem]? {
    return [
      .init(name: "q", value: searchWords),
      .init(name: "order", value: "desc"),
    ]
  }
}
