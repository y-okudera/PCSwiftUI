//
//  APILive.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/02.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import ComposableArchitecture

// MARK: - Live

extension APIClient {
  public static let live = Self(
    cardsPage: { number, size in
      let route = APIRoute.cardsPage(number: number, size: size)
      let request = APIRouter.request(for: route)
      return requestPublisher(request)
        .apiDecode(as: Cards.self)
        .eraseToEffect()
    }
  )

  private static func requestPublisher(_ request: URLRequest) -> AnyPublisher<Data, APIError> {
    URLSession.shared.dataTaskPublisher(for: request)
      .mapError { .network(error: $0) }
      .map { $0.data }
      .eraseToAnyPublisher()
  }
}
