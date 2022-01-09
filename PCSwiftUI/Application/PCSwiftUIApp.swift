//
//  PCSwiftUIApp.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/01.
//

import SwiftUI

@main
struct PCSwiftUIApp: App {
  // AppDelegateを参照
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      RepositoryListView()
    }
  }
}
