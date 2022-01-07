//
//  ContentView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/01.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var store: RepositoryListStore = .shared
  private var actionCreator: RepositoryListActionCreator

  init(actionCreator: RepositoryListActionCreator = .init()) {
    self.actionCreator = actionCreator
  }

  var body: some View {
    SearchNavigation(text: $store.searchQuery, search: { actionCreator.searchRepositories(searchWords: store.searchQuery) }) {
      List(store.repositories) { repository in
        RepositoryListRow(repository: repository)
      }
      .alert(isPresented: $store.isErrorShown) { () -> Alert in
        Alert(title: Text("Error"), message: Text(store.errorMessage))
      }
      .navigationBarTitle(Text("Repositories"))
    }
    .edgesIgnoringSafeArea(.top)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
