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
  /// エラータイトル
  @Published var errorTitle = ""
  /// エラーメッセージ
  @Published var errorMessage = ""
  /// エラーダイアログトリガー
  @Published var isErrorShown = false
  /// リポジトリ一覧
  @Published private(set) var repositoryListState = RepositoryListState()
  /// ページ
  @Published private(set) var page = 1
  /// 次のページがあるか
  ///
  /// - Note: 初期状態は検索未実施のためfalse
  @Published private(set) var hasNext = false

  init(dispatcher: RepositoryListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .initializeRepositoryListState(let apiResponse):
        self.repositoryListState = .init(response: apiResponse.response)
        self.page += 1
        self.hasNext = apiResponse.gitHubAPIPagination?.hasNext ?? false
      case .updateRepositoryListState(let apiResponse):
        self.repositoryListState.append(response: apiResponse.response)
        self.page += 1
        self.hasNext = apiResponse.gitHubAPIPagination?.hasNext ?? false
      case .updateErrorMessage(let title, let message):
        self.errorTitle = title
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}
