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
