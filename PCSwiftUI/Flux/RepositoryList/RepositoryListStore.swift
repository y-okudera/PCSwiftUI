//
//  RepositoryListStore.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Combine
import Foundation
import SwiftUI

final class RepositoryListStore: ObservableObject {
  static let shared = RepositoryListStore()

  @Published private(set) var repositories: [Repository] = []
  @Published var isErrorShown = false
  @Published var errorMessage = ""
  @Published private(set) var shouldShowIcon = false

  init(dispatcher: RepositoryListDispatcher = .shared) {
    dispatcher.register { [weak self] (action) in
      guard let strongSelf = self else { return }

      switch action {
      case .updateRepositories(let repositories): strongSelf.repositories = repositories
      case .updateErrorMessage(let message): strongSelf.errorMessage = message
      case .showError: strongSelf.isErrorShown = true
      case .showIcon: break
      }
    }
  }
}
