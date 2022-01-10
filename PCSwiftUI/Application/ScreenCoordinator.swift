//
//  ScreenCoordinator.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import SwiftUI

final class ScreenCoordinator: ObservableObject {
  @Published var selectedTabItem = 0
  @Published var selectedPushedItem: PushedItem?
}

extension ScreenCoordinator {
  enum PushedItem: Hashable {
    case repositoryOwnerWebView(url: URL)
  }

}
