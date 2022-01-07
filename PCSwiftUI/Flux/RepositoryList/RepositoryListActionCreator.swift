//
//  RepositoryListActionCreator.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Combine

final class RepositoryListActionCreator {
  private let dispatcher: RepositoryListDispatcher

  @Injected(\.apiRepositoryProvider)
  private var apiRepository: APIRepositoryProviding

  private let searchRepositoriesSubject = PassthroughSubject<String, Never>()
  private let responseSubject = PassthroughSubject<SearchRepositoryResponse, Never>()
  private let errorSubject = PassthroughSubject<APIError, Never>()
  private var cancellables: [AnyCancellable] = []

  init(dispatcher: RepositoryListDispatcher = .shared) {
    self.dispatcher = dispatcher

    bindData()
    bindActions()
  }

  func bindData() {
    // searchRepositoriesSubjectにstringが送られてきたらAPIリクエストする
    let responsePublisher =
      searchRepositoriesSubject.share()
      .flatMap { [apiRepository] term in
        apiRepository.response(from: SearchRepositoryRequest(searchWords: term))
          .catch { [weak self] error -> Empty<SearchRepositoryResponse, Never> in
            self?.errorSubject.send(error)
            return .init()
          }
      }

    let responseStream =
      responsePublisher
      .share()
      .subscribe(responseSubject)

    cancellables += [
      responseStream
    ]
  }

  func bindActions() {
    let responseDataStream =
      responseSubject
      .map { $0.items }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateRepositories($0)) })

    // errorSubjectにerrorが送られてきたら、エラーメッセージを更新
    let errorDataStream =
      errorSubject
      .map { error -> String in
        switch error {
        case .responseError: return "network error"
        case .parseError: return "parse error"
        }
      }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateErrorMessage($0)) })

    // errorSubjectにerrorが送られてきたら、エラーメッセージを表示
    let errorStream =
      errorSubject
      .map { _ in }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.showError) })

    cancellables += [
      responseDataStream,
      errorDataStream,
      errorStream,
    ]
  }

  func searchRepositories(searchWords: String) {
    searchRepositoriesSubject.send(searchWords)
  }
}
