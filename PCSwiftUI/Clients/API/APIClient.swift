//
//  APIClient.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/02.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import ComposableArchitecture

public struct APIClient {
  public var cardsPage: (_ number: Int, _ size: Int) -> Effect<Cards, APIError>
}

// MARK: - Mock

extension APIClient {
  public static func mock(all: @escaping (Int, Int) -> Effect<Cards, APIError> = { _, _ in fatalError("Unmocked") }) -> Self {
    Self(
      cardsPage: all
    )
  }

  public static func mockPreview(all: @escaping (Int, Int) -> Effect<Cards, APIError> = { _, _ in .init(value: Cards.mock) }) -> Self {
    Self(
      cardsPage: all
    )
  }
}
