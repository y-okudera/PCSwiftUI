//
//  UserListAction.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Foundation

enum UserListAction {
  ///  1ページ目の読み込み結果を反映
  case initializeUserListState(APIResponse<SearchUserResponse>)
  ///  2ページ目以降の読み込み結果を反映
  case updateUserListState(APIResponse<SearchUserResponse>)
  ///  エラーメッセージを反映
  case updateErrorMessage(String, String)
  ///  エラーを表示
  case showError
}
