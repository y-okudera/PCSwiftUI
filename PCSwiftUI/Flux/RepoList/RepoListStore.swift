//
//  RepoListStore.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Combine

final class RepoListStore: ObservableObject {
  static let shared = RepoListStore()

  /// 検索語
  @Published var searchQuery = ""
  /// エラータイトル
  @Published var errorTitle = ""
  /// エラーメッセージ
  @Published var errorMessage = ""
  /// エラーダイアログトリガー
  @Published var isErrorShown = false
  /// リポジトリ一覧
  @Published private(set) var repoAggregateRoot = RepoAggregateRoot()

  init(dispatcher: RepoListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .initializePage:
        self.repoAggregateRoot = .init()
      case .initializeRepoListState(let apiResponse):
        print("initializeRepoListState page=\(self.repoAggregateRoot.page)")
        self.repoAggregateRoot.set(
          response: apiResponse.response,
          hasNext: apiResponse.gitHubAPIPagination?.hasNext ?? false
        )
      case .updateRepoListState(let apiResponse):
        print("updateRepoListState page=\(self.repoAggregateRoot.page)")
        self.repoAggregateRoot.append(
          response: apiResponse.response,
          hasNext: apiResponse.gitHubAPIPagination?.hasNext ?? false
        )
      case .updateErrorMessage(let title, let message):
        self.errorTitle = title
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}
