//
//  UserListStore.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Combine

final class UserListStore: ObservableObject {
  static let shared = UserListStore()

  /// 検索語
  @Published var searchQuery = ""
  /// エラータイトル
  @Published var errorTitle = ""
  /// エラーメッセージ
  @Published var errorMessage = ""
  /// エラーダイアログトリガー
  @Published var isErrorShown = false
  /// リポジトリ一覧
  @Published private(set) var userAggregateRoot = UserAggregateRoot()

  init(dispatcher: UserListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .initializePage:
        self.userAggregateRoot = .init()
      case .initializeUserListState(let apiResponse):
        self.userAggregateRoot.set(
          response: apiResponse.response,
          hasNext: apiResponse.gitHubAPIPagination?.hasNext ?? false
        )
        print("initializeRepoListState page=\(self.userAggregateRoot.page) hasNext=\(self.userAggregateRoot.hasNext)")
      case .updateUserListState(let apiResponse):
        self.userAggregateRoot.append(
          response: apiResponse.response,
          hasNext: apiResponse.gitHubAPIPagination?.hasNext ?? false
        )
        print("updateUserListState page=\(self.userAggregateRoot.page) hasNext=\(self.userAggregateRoot.hasNext)")
      case .updateErrorMessage(let title, let message):
        self.errorTitle = title
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}
