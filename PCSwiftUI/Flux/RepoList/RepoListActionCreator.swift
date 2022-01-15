//
//  RepoListActionCreator.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Combine
import Foundation

final class RepoListActionCreator {
  private let dispatcher: RepoListDispatcher

  @Injected(\.apiRepositoryProvider)
  private var apiRepository: APIRepositoryProviding

  private var cancellables: [AnyCancellable] = []

  private let searchRepositoriesSubject = PassthroughSubject<String, Never>()
  private let responseSubject = PassthroughSubject<APIResponse<SearchRepositoryResponse>, Never>()

  private let additionalSearchRepositoriesSubject = PassthroughSubject<(String, Int), Never>()
  private let additionalResponseSubject = PassthroughSubject<APIResponse<SearchRepositoryResponse>, Never>()

  private let errorSubject = PassthroughSubject<APIError, Never>()

  init(dispatcher: RepoListDispatcher = .shared) {
    self.dispatcher = dispatcher
    bindData()
    bindActions()
  }

  func bindData() {
    // searchRepositoriesSubjectにstringが送られてきたらAPIリクエストする
    let responsePublisher =
      searchRepositoriesSubject.share()
      .flatMap { [apiRepository] searchQuery in
        apiRepository.response(from: SearchRepositoryRequest(searchQuery: searchQuery, page: 1))
          .catch { [weak self] error -> Empty<APIResponse<SearchRepositoryResponse>, Never> in
            self?.errorSubject.send(APIError(error: error))
            return .init()
          }
      }

    let responseStream =
      responsePublisher
      .share()
      .subscribe(responseSubject)

    // additionalSearchRepositoriesSubjectに(string, int)が送られてきたら追加読み込みのAPIリクエストする
    let additionalResponsePublisher =
      additionalSearchRepositoriesSubject.share()
      .flatMap { [apiRepository] searchQuery, page in
        apiRepository.response(from: SearchRepositoryRequest(searchQuery: searchQuery, page: page))
          .catch { [weak self] error -> Empty<APIResponse<SearchRepositoryResponse>, Never> in
            self?.errorSubject.send(APIError(error: error))
            return .init()
          }
      }

    let additionalResponseStream =
      additionalResponsePublisher
      .share()
      .subscribe(additionalResponseSubject)

    cancellables += [
      responseStream,
      additionalResponseStream,
    ]
  }

  func bindActions() {
    // リポジトリ検索結果を反映
    let responseDataStream =
      responseSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.initializeRepoListState($0)) })

    // 検索結果が0件の場合、エラーメッセージを更新
    let emptyDataStream =
      responseSubject
      .filter { $0.response.items.isEmpty }
      .map { _ in ("検索結果", "該当するリポジトリがありません。") }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateErrorMessage($0.0, $0.1)) })

    // 検索結果が0件の場合、エラーメッセージを表示
    let isEmptyErrorStream =
      responseSubject
      .filter { $0.response.items.isEmpty }
      .map { _ in }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.showError) })

    let additionalResponseDataStream =
      additionalResponseSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateRepoListState($0)) })

    // errorSubjectにerrorが送られてきたら、エラーメッセージを更新
    let errorDataStream =
      errorSubject
      .map { error -> (String, String) in
        let nsError = error as NSError
        return (nsError.localizedDescription, (nsError.localizedRecoverySuggestion ?? "エラーが発生しました。"))
      }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateErrorMessage($0.0, $0.1)) })

    // errorSubjectにerrorが送られてきたら、エラーメッセージを表示
    let errorStream =
      errorSubject
      .map { _ in }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.showError) })

    cancellables += [
      responseDataStream,
      emptyDataStream,
      isEmptyErrorStream,
      additionalResponseDataStream,
      errorDataStream,
      errorStream,
    ]
  }

  func searchRepositories(searchQuery: String) {
    searchRepositoriesSubject.send(searchQuery)
  }

  func additionalSearchRepositories(searchQuery: String, page: Int) {
    additionalSearchRepositoriesSubject.send((searchQuery, page))
  }
}
