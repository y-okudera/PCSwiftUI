//
//  RepositoryListAction.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation

enum RepositoryListAction {
  case updateRepositories([Repository])
  case updateErrorMessage(String)
  case showError
}
