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
  @Published private(set) var repoListState = RepoListState()
  /// ページ
  @Published private(set) var page = 1
  /// 次のページがあるか
  ///
  /// - Note: 初期状態は検索未実施のためfalse
  @Published private(set) var hasNext = false

  init(dispatcher: RepoListDispatcher = .shared) {
    dispatcher.register { [weak self] action in
      guard let self = self else { return }

      switch action {
      case .initializeRepoListState(let apiResponse):
        self.page += 1
        self.hasNext = apiResponse.gitHubAPIPagination?.hasNext ?? false
        self.repoListState = .init(response: apiResponse.response)
      case .updateRepoListState(let apiResponse):
        self.page += 1
        self.hasNext = apiResponse.gitHubAPIPagination?.hasNext ?? false
        self.repoListState.append(response: apiResponse.response)
      case .updateErrorMessage(let title, let message):
        self.errorTitle = title
        self.errorMessage = message
      case .showError:
        self.isErrorShown = true
      }
    }
  }
}
