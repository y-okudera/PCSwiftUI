//
//  RepositoryListView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/01.
//

import SwiftUI

struct RepositoryListView<R: RepositoryListRouter>: View {
  @Environment(\.colorScheme) private var colorScheme

  @ObservedObject var store: RepositoryListStore = .shared
  private var actionCreator: RepositoryListActionCreator
  @StateObject private var router: R

  init(router: R, actionCreator: RepositoryListActionCreator = .init()) {
    _router = StateObject(wrappedValue: router)
    self.actionCreator = actionCreator
  }

  var body: some View {
    SearchNavigation(text: $store.searchQuery, search: { actionCreator.searchRepositories(searchQuery: store.searchQuery) }) {
      List {
        ForEach(store.repositoryListState.repositories) { repository in
          RepositoryListRow(repository: repository) {
            router.navigateToRepositoryOwner(urlString: repository.owner.htmlUrl.absoluteString)
          }
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
      .alert(isPresented: $store.isErrorShown) { () -> Alert in
        Alert(title: Text(store.errorTitle), message: Text(store.errorMessage))
      }
      .navigationBarTitle(Text("Repositories"))
      .navigation(router)
    }
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

#if DEBUG
  struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepositoryListView(router: RepositoryListRouterImpl(isPresented: .constant(false)))
          .preferredColorScheme($0)
      }
    }
  }
#endif
