//
//  UserListDispatcher.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Combine

final class UserListDispatcher {
  static let shared = UserListDispatcher()

  private let actionSubject = PassthroughSubject<UserListAction, Never>()
  private var cancellables: [AnyCancellable] = []

  func register(callback: @escaping (UserListAction) -> Void) {
    let actionStream = actionSubject.sink(receiveValue: callback)
    cancellables += [actionStream]
  }

  func dispatch(_ action: UserListAction) {
    actionSubject.send(action)
  }
}
