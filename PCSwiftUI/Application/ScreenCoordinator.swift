//
//  ScreenCoordinator.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import SwiftUI

final class ScreenCoordinator: ObservableObject {
  @Published var selectedTabItem = 0
  @Published var selectedUserPageUrl = Selection<String>(isSelected: false, item: nil)
}

extension ScreenCoordinator {
  struct Selection<T> {
    var isSelected = false
    var item: T?
  }
}
