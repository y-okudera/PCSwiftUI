//
//  APIResponse.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct APIResponse<T: Decodable> {
  var response: T
  var statusCode: Int
  var responseHeaderFields: [AnyHashable: Any]

  /// GitHub API specific property
  var gitHubAPIPagination: GitHubAPIPagination?

  init(response: T, httpURLResponse: HTTPURLResponse) {
    self.response = response
    self.statusCode = httpURLResponse.statusCode
    self.responseHeaderFields = httpURLResponse.allHeaderFields
    self.gitHubAPIPagination = .init(httpURLResponse: httpURLResponse)
    print("URL \(httpURLResponse.url?.absoluteString ?? "")")
    print("gitHubAPIPagination \(gitHubAPIPagination.debugDescription)")
  }
}

// MARK: GitHub API Pagination
struct GitHubAPIPagination {
  let nextUrl: URL?
  let firstUrl: URL?
  let lastUrl: URL?

  init(nextUrl: URL?, firstUrl: URL?, lastUrl: URL?) {
    self.nextUrl = nextUrl
    self.firstUrl = firstUrl
    self.lastUrl = lastUrl
  }

  init(httpURLResponse: HTTPURLResponse) {
    guard let linkField = httpURLResponse.allHeaderFields["Link"] as? String else {
      self = .init(nextUrl: nil, firstUrl: nil, lastUrl: nil)
      return
    }

    let dictionary =
      linkField
      .components(separatedBy: ",")
      .reduce(into: [String: String]()) {
        let components = $1.components(separatedBy: "; ")
        let cleanPath = components[safe: 0]?.trimmingCharacters(in: CharacterSet(charactersIn: " <>"))
        if let key = components[safe: 1] {
          $0[key] = cleanPath
        }
      }

    let nextUrl: URL? = {
      guard let next = dictionary["rel=\"next\""] else {
        return nil
      }
      return URL(string: next)
    }()

    let firstUrl: URL? = {
      guard let first = dictionary["rel=\"first\""] else {
        return nil
      }
      return URL(string: first)
    }()

    let lastUrl: URL? = {
      guard let last = dictionary["rel=\"last\""] else {
        return nil
      }
      return URL(string: last)
    }()

    self = .init(nextUrl: nextUrl, firstUrl: firstUrl, lastUrl: lastUrl)
  }
}
