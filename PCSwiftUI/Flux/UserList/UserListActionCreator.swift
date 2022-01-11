//
//  UserListActionCreator.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Combine
import Foundation

final class UserListActionCreator {
  private let dispatcher: UserListDispatcher

  @Injected(\.apiRepositoryProvider)
  private var apiRepository: APIRepositoryProviding

  private var cancellables: [AnyCancellable] = []

  private let searchUsersSubject = PassthroughSubject<String, Never>()
  private let responseSubject = PassthroughSubject<APIResponse<SearchUserResponse>, Never>()

  private let additionalSearchUsersSubject = PassthroughSubject<(String, Int), Never>()
  private let additionalResponseSubject = PassthroughSubject<APIResponse<SearchUserResponse>, Never>()

  private let errorSubject = PassthroughSubject<APIError, Never>()

  init(dispatcher: UserListDispatcher = .shared) {
    self.dispatcher = dispatcher
    bindData()
    bindActions()
  }

  func bindData() {
    // searchUsersSubjectにstringが送られてきたらAPIリクエストする
    let responsePublisher =
      searchUsersSubject.share()
      .flatMap { [apiRepository] searchQuery in
        apiRepository.response(from: SearchUserRequest(searchQuery: searchQuery, page: 1))
          .catch { [weak self] error -> Empty<APIResponse<SearchUserResponse>, Never> in
            self?.errorSubject.send(APIError(error: error))
            return .init()
          }
      }

    let responseStream =
      responsePublisher
      .share()
      .subscribe(responseSubject)

    // additionalSearchUsersSubjectに(string, int)が送られてきたら追加読み込みのAPIリクエストする
    let additionalResponsePublisher =
      additionalSearchUsersSubject.share()
      .flatMap { [apiRepository] searchQuery, page in
        apiRepository.response(from: SearchUserRequest(searchQuery: searchQuery, page: page))
          .catch { [weak self] error -> Empty<APIResponse<SearchUserResponse>, Never> in
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
    // ユーザー検索結果を反映
    let responseDataStream =
      responseSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.initializeUserListState($0)) })

    // 検索結果が0件の場合、エラーメッセージを更新
    let emptyDataStream =
      responseSubject
      .filter { $0.response.items.isEmpty }
      .map { _ in ("検索結果", "該当するユーザーがいません。") }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateErrorMessage($0.0, $0.1)) })

    // 検索結果が0件の場合、エラーメッセージを表示
    let isEmptyErrorStream =
      responseSubject
      .filter { $0.response.items.isEmpty }
      .map { _ in }
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.showError) })

    let additionalResponseDataStream =
      additionalResponseSubject
      .sink(receiveValue: { [dispatcher] in dispatcher.dispatch(.updateUserListState($0)) })

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

  func searchUsers(searchQuery: String) {
    searchUsersSubject.send(searchQuery)
  }

  func additionalSearchUsers(searchQuery: String, page: Int) {
    additionalSearchUsersSubject.send((searchQuery, page))
  }
}
