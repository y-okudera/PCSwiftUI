//
//  RepositoryListAction.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation

enum RepositoryListAction {
  ///  1ページ目の読み込み結果を反映
  case initializeRepositoryListState(APIResponse<SearchRepositoryResponse>)
  ///  2ページ目以降の読み込み結果を反映
  case updateRepositoryListState(APIResponse<SearchRepositoryResponse>)
  ///  エラーメッセージを反映
  case updateErrorMessage(String, String)
  ///  エラーを表示
  case showError
}
