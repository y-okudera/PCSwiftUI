//
//  RepositoryListStore.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Combine

final class RepositoryListStore: ObservableObject {
  static let shared = RepositoryListStore()

  /// 検索語
  @Published var searchQuery = ""
  /// エラーメッセージ
  @Published var errorMessage = ""
  /// エラーダイアログトリガー
  @Published var isErrorShown = false

  /// 検索結果
  @Published private(set) var repositories: [Repository] = []

  init(dispatcher: RepositoryListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .updateRepositories(let repositories):
        self.repositories = repositories
      case .updateErrorMessage(let message):
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}
