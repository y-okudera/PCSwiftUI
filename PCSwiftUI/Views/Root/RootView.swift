//
//  RootView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import SwiftUI

struct RootView: View {

  @EnvironmentObject private var screenCoordinator: ScreenCoordinator

  var body: some View {
    TabView(selection: $screenCoordinator.selectedTabItem) {
      RepositoryListView()
        .tabItem {
          VStack {
            Image(systemName: "magnifyingglass")
            Text("Search")
          }
        }
        .tag(0)
      #warning("Will impl screen")
      Text("ToDo")
        .tabItem {
          VStack {
            Image(systemName: "gearshape")
            Text("設定")
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
        screenCoordinator.selectedUserPageUrl = ScreenCoordinator.Selection(isSelected: false, item: nil)
        // 遷移アニメーションが見えるようにするためdelayをかける
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
          screenCoordinator.selectedUserPageUrl = ScreenCoordinator.Selection(isSelected: true, item: urlString)
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
