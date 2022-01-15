//
//  RepoRepositoryProviderKey.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/16.
//

import Foundation

private struct RepoRepositoryProviderKey: InjectionKey {
  static var currentValue: RepoRepositoryProviding = RepoRepository()
}

extension InjectedValues {
  var repoRepositoryProvider: RepoRepositoryProviding {
    get { Self[RepoRepositoryProviderKey.self] }
    set { Self[RepoRepositoryProviderKey.self] = newValue }
  }
}
