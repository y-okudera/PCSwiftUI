//
//  RepoListAction.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation

enum RepoListAction {
  /// ページ番号を初期化する
  case initializePage
  ///  1ページ目の読み込み結果を反映
  case initializeRepoListState(APIResponse<SearchRepositoryResponse>)
  ///  2ページ目以降の読み込み結果を反映
  case updateRepoListState(APIResponse<SearchRepositoryResponse>)
  ///  エラーメッセージを反映
  case updateErrorMessage(String, String)
  ///  エラーを表示
  case showError
}
