//
//  UserListStore.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Domain

public final class UserListStore: ObservableObject {
  public static let shared = UserListStore()

  /// 検索語
  @Published public var searchQuery = ""
  /// エラータイトル
  @Published public var errorTitle = ""
  /// エラーメッセージ
  @Published public var errorMessage = ""
  /// エラーダイアログトリガー
  @Published public var isErrorShown = false
  /// リポジトリ一覧
  @Published public private(set) var userAggregateRoot = UserAggregateRoot()

  init(dispatcher: UserListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .initializePage:
        self.userAggregateRoot = .init()
      case .initializeUserListState(let newValue):
        self.userAggregateRoot.set(oldValue: self.userAggregateRoot, newValue: newValue)
        print("initializeRepoListState page=\(self.userAggregateRoot.page) hasNext=\(self.userAggregateRoot.hasNext)")
      case .updateUserListState(let newValue):
        self.userAggregateRoot.set(oldValue: self.userAggregateRoot, newValue: newValue)
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