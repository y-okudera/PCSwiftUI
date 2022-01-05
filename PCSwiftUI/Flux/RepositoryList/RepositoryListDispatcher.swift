//
//  RepositoryListDispatcher.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation
import Combine

final class RepositoryListDispatcher {
    static let shared = RepositoryListDispatcher()

    private let actionSubject = PassthroughSubject<RepositoryListAction, Never>()
    private var cancellables: [AnyCancellable] = []

    func register(callback: @escaping (RepositoryListAction) -> ()) {
        let actionStream = actionSubject.sink(receiveValue: callback)
        cancellables += [actionStream]
    }

    func dispatch(_ action: RepositoryListAction) {
        actionSubject.send(action)
    }
}
