//
//  AnyPublisher+.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/02.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import ComposableArchitecture

extension AnyPublisher where Output == Data, Failure == APIError {
  func apiDecode<Response: Decodable>(as type: Response.Type, file: StaticString = #file, line: UInt = #line) -> Effect<Response, APIError> {
    flatMap { data -> AnyPublisher<Response, APIError> in
      // Decode Response
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return Just(data)
        .tryMap { try decoder.decode(Response.self, from: $0) }
        .mapError { .decoding(error: $0) }
        .eraseToAnyPublisher()
    }
    .eraseToEffect()
  }
}
