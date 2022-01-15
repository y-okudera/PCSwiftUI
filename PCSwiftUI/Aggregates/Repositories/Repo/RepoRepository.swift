//
//  RepoRepository.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/16.
//

import Combine

protocol RepoRepositoryProviding {
  func response(searchQuery: String, page: Int) -> AnyPublisher<APIResponse<SearchRepositoryResponse>, APIError>
}

struct RepoRepository: RepoRepositoryProviding {

  @Injected(\.apiClientProvider)
  private var apiClient: APIClientProviding

  func response(searchQuery: String, page: Int) -> AnyPublisher<APIResponse<SearchRepositoryResponse>, APIError> {
    apiClient.response(from: SearchRepositoryRequest(searchQuery: searchQuery, page: page))
      .mapError { APIError(error: $0) }
      .eraseToAnyPublisher()
  }
}
