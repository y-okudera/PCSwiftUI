//
//  APIError.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/02.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public enum APIError: Error {
  case network(error: Error)
  case decoding(error: Error)
}

extension APIError: Equatable {
  public static func == (lhs: APIError, rhs: APIError) -> Bool {
    switch (lhs, rhs) {
    case (.network(let lhsError), .network(let rhsError)):
      return lhsError.isEqual(to: rhsError)
    case (.decoding(let lhsError), .decoding(let rhsError)):
      return lhsError.isEqual(to: rhsError)
    default:
      return false
    }
  }
}

enum ErrorUtility {
  static func areEqual(_ lhs: Error, _ rhs: Error) -> Bool {
    return lhs.reflectedString == rhs.reflectedString
  }
}
