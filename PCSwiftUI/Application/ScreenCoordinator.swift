//
//  ScreenCoordinator.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import SwiftUI

class ScreenCoordinator: ObservableObject {
  @Published var selectedTabItem = 0
  @Published var selectedUserPageUrl = Selection<String>(isSelected: false, item: nil)
}

struct Selection<T> {
  var isSelected = false
  var item: T?
}
