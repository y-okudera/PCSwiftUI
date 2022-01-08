//
//  RepositoryListView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/01.
//

import SwiftUI

struct RepositoryListView: View {
  @ObservedObject var store: RepositoryListStore = .shared
  private var actionCreator: RepositoryListActionCreator

  init(actionCreator: RepositoryListActionCreator = .init()) {
    self.actionCreator = actionCreator
  }

  var body: some View {
    SearchNavigation(text: $store.searchQuery, search: { actionCreator.searchRepositories(searchWords: store.searchQuery) }) {
      List {
        ForEach(store.repositoryListState.repositories) { repository in
          RepositoryListRow(repository: repository)
        }

        // リポジトリの検索結果が0件ではなく、次のページがある場合、リスト末尾にインジケーターを表示
        if !store.repositoryListState.repositories.isEmpty && store.hasNext {
          HStack {
            Spacer()
            ActivityIndicator()
              .onAppear {
                actionCreator.additionalSearchRepositories(searchWords: store.searchQuery, page: store.page)
              }
            Spacer()
          }
        }
      }
      .alert(isPresented: $store.isErrorShown) { () -> Alert in
        Alert(title: Text(store.errorTitle), message: Text(store.errorMessage))
      }
      .navigationBarTitle(Text("Repositories"))
    }
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

struct RepositoryListView_Previews: PreviewProvider {
  static var previews: some View {
    RepositoryListView()
  }
}
