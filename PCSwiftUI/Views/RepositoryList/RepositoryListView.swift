//
//  RepositoryListView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/01.
//

import SwiftUI

struct RepositoryListView: View {
  @Environment(\.colorScheme) private var colorScheme
  @EnvironmentObject private var screenCoordinator: ScreenCoordinator

  @ObservedObject var store: RepositoryListStore = .shared
  private var actionCreator: RepositoryListActionCreator

  init(actionCreator: RepositoryListActionCreator = .init()) {
    self.actionCreator = actionCreator
  }

  var body: some View {
    SearchNavigation(text: $store.searchQuery, search: { actionCreator.searchRepositories(searchQuery: store.searchQuery) }) {
      List {
        ForEach(store.repositoryListState.repositories) { repository in
          RepositoryListRow(repository: repository)
        }
        HStack {
          Spacer()
          ActivityIndicator()
            .onAppear {
              actionCreator.additionalSearchRepositories(searchQuery: store.searchQuery, page: store.page)
            }
          Spacer()
        }
        // 次のページがない場合、リスト末尾にインジケーターを表示しない
        .hidden(!store.hasNext)
      }
      .background(
        NavigationLink(
          destination: RepositoryOwnerWebView(urlString: screenCoordinator.selectedUserPageUrl.item),
          isActive: $screenCoordinator.selectedUserPageUrl.isSelected,
          label: { EmptyView() }
        )
      )
      .alert(isPresented: $store.isErrorShown) { () -> Alert in
        Alert(title: Text(store.errorTitle), message: Text(store.errorMessage))
      }
      .navigationBarTitle(Text("Repositories"))
    }
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

#if DEBUG
  struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepositoryListView()
          .environmentObject(ScreenCoordinator())
          .preferredColorScheme($0)
      }
    }
  }
#endif
