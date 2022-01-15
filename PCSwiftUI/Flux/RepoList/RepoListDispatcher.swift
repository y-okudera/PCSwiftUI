//
//  RepoListDispatcher.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Combine

final class RepoListDispatcher {
  static let shared = RepoListDispatcher()

  private let actionSubject = PassthroughSubject<RepoListAction, Never>()
  private var cancellables: [AnyCancellable] = []

  func register(callback: @escaping (RepoListAction) -> Void) {
    let actionStream = actionSubject.sink(receiveValue: callback)
    cancellables += [actionStream]
  }

  func dispatch(_ action: RepoListAction) {
    actionSubject.send(action)
  }
}
