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
  @Published private(set) var userListState = UserListState()
  /// ページ
  @Published private(set) var page = 1
  /// 次のページがあるか
  ///
  /// - Note: 初期状態は検索未実施のためfalse
  @Published private(set) var hasNext = false

  init(dispatcher: UserListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .initializeUserListState(let apiResponse):
        self.page += 1
        self.userListState = .init(response: apiResponse.response)
        self.hasNext = self.userListState.hasNext
      case .updateUserListState(let apiResponse):
        self.page += 1
        self.userListState.append(response: apiResponse.response)
        self.hasNext = self.userListState.hasNext
      case .updateErrorMessage(let title, let message):
        self.errorTitle = title
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}
