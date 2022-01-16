//
//  RootView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

public struct RootView: View {

  public init() {

  }

  @State private var tabIndex: Int = 0
  private let repoListRouter = RepoListRouterImpl(isPresented: .constant(false))
  private let userListRouter = UserListRouterImpl(isPresented: .constant(false))

  public var body: some View {
    TabView(selection: $tabIndex) {
      RepoListView(router: repoListRouter)
        .tabItem {
          VStack {
            Image(systemName: "magnifyingglass")
            Text("Search")
          }
        }
        .tag(0)
      UserListView(router: userListRouter)
        .tabItem {
          VStack {
            Image(systemName: "person.fill")
            Text("User")
          }
        }
        .tag(1)
    }
    .onOpenURL(perform: { url in
      switch Deeplink(url: url) {
      case .tab(let index):
        print("Deeplink .tab index=\(index)")
        // タブを選択
        tabIndex = index
      case .repo(let urlString):
        print("Deeplink .repo urlString=\(urlString)")
        // Searchタブを選択
        tabIndex = 0
        // Push遷移していた場合にPopする
        repoListRouter.pop()
        // 遷移アニメーションが見えるようにするためdelayをかける
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
          repoListRouter.navigateToGeneralWebView(urlString: urlString)
        }
      case .user(let urlString):
        print("Deeplink .user urlString=\(urlString)")
        // Userタブを選択
        tabIndex = 1
        // Push遷移していた場合にPopする
        userListRouter.pop()
        // 遷移アニメーションが見えるようにするためdelayをかける
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
          userListRouter.navigateToGeneralWebView(urlString: urlString)
        }
      case .none:
        print("Deeplink none.")
      }
    })
  }
}

#if DEBUG
  struct RootView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RootView()
          .preferredColorScheme($0)
      }
    }
  }
#endif
