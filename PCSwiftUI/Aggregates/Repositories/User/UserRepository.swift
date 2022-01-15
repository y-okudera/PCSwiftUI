//
//  UserRepository.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/16.
//

import Combine

protocol UserRepositoryProviding {
  func response(searchQuery: String, page: Int) -> AnyPublisher<APIResponse<SearchUserResponse>, APIError>
}

struct UserRepository: UserRepositoryProviding {

  @Injected(\.apiClientProvider)
  private var apiClient: APIClientProviding

  func response(searchQuery: String, page: Int) -> AnyPublisher<APIResponse<SearchUserResponse>, APIError> {
    apiClient.response(from: SearchUserRequest(searchQuery: searchQuery, page: page))
      .mapError { APIError(error: $0) }
      .eraseToAnyPublisher()
  }
}
