//
//  RootView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import SwiftUI

struct RootView: View {

  @EnvironmentObject private var screenCoordinator: ScreenCoordinator

  private let repositoryListRouter = RepositoryListRouterImpl(isPresented: .constant(false))
  private let userListRouter = UserListRouterImpl(isPresented: .constant(false))

  var body: some View {
    TabView(selection: $screenCoordinator.selectedTabItem) {
      RepositoryListView(router: repositoryListRouter)
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
        }.tag(1)
    }
    .onOpenURL(perform: { url in
      switch Deeplink(url: url) {
      case .tab(let index):
        print("Deeplink .tab index=\(index)")
        // タブを選択
        screenCoordinator.selectedTabItem = index
      case .user(let urlString):
        print("Deeplink .user urlString=\(urlString)")
        // Searchタブを選択
        screenCoordinator.selectedTabItem = 0
        // Push遷移していた場合にPopする
        repositoryListRouter.pop()
        // 遷移アニメーションが見えるようにするためdelayをかける
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
          repositoryListRouter.navigateToRepositoryOwner(urlString: urlString)
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
          .environmentObject(ScreenCoordinator())
          .preferredColorScheme($0)
      }
    }
  }
#endif
