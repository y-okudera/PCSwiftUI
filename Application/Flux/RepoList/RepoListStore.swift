//
//  RepoListStore.swift
//  Application
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Combine
import Domain

public final class RepoListStore: ObservableObject {
  public static let shared = RepoListStore()

  /// 検索語
  @Published public var searchQuery = ""
  /// エラータイトル
  @Published public var errorTitle = ""
  /// エラーメッセージ
  @Published public var errorMessage = ""
  /// エラーダイアログトリガー
  @Published public var isErrorShown = false
  /// リポジトリ一覧
  @Published public private(set) var repoAggregateRoot = RepoAggregateRoot()

  init(dispatcher: RepoListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .initializePage:
        self.repoAggregateRoot = .init()
      case .initializeRepoListState(let newValue):
        print("initializeRepoListState page=\(self.repoAggregateRoot.page)")
        self.repoAggregateRoot.set(oldValue: self.repoAggregateRoot, newValue: newValue)
      case .updateRepoListState(let newValue):
        print("updateRepoListState page=\(self.repoAggregateRoot.page)")
        self.repoAggregateRoot.set(oldValue: self.repoAggregateRoot, newValue: newValue)
      case .updateErrorMessage(let title, let message):
        self.errorTitle = title
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}
