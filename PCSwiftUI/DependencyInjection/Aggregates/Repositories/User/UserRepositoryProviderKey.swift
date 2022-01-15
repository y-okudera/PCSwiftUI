//
//  UserRepositoryProviderKey.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/16.
//

import Foundation

private struct UserRepositoryProviderKey: InjectionKey {
  static var currentValue: UserRepositoryProviding = UserRepository()
}

extension InjectedValues {
  var userRepositoryProvider: UserRepositoryProviding {
    get { Self[UserRepositoryProviderKey.self] }
    set { Self[UserRepositoryProviderKey.self] = newValue }
  }
}
