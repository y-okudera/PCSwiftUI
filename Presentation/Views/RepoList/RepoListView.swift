//
//  RepoListView.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/01.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Application
import SwiftUI

struct RepoListView<R: RepoListRouter>: View {
  @Environment(\.colorScheme) private var colorScheme

  @ObservedObject var store: RepoListStore = .shared
  private var actionCreator: RepoListActionCreator
  @StateObject private var router: R

  init(router: R, actionCreator: RepoListActionCreator = .init()) {
    _router = StateObject(wrappedValue: router)
    self.actionCreator = actionCreator
  }

  var body: some View {
    SearchNavigation(text: $store.searchQuery, search: { actionCreator.searchRepositories(searchQuery: store.searchQuery) }) {
      List {
        ForEach(store.repoAggregateRoot.repositories) { repository in
          RepoListRow(title: repository.fullName) {
            router.navigateToRepositoryOwner(urlString: repository.owner.htmlUrl.absoluteString)
          }
        }
        HStack {
          Spacer()
          ActivityIndicator()
            .onAppear {
              actionCreator.additionalSearchRepositories(searchQuery: store.searchQuery, page: store.repoAggregateRoot.page)
            }
          Spacer()
        }
        // 次のページがない場合、リスト末尾にインジケーターを表示しない
        .hidden(!store.repoAggregateRoot.hasNext)
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
  struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepoListView(router: RepoListRouterImpl(isPresented: .constant(false)))
          .preferredColorScheme($0)
      }
    }
  }
#endif