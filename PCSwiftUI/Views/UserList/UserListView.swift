//
//  UserListView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import SwiftUI

struct UserListView: View {
  @Environment(\.colorScheme) private var colorScheme

  @ObservedObject var store: UserListStore = .shared
  private var actionCreator: UserListActionCreator

  init(actionCreator: UserListActionCreator = .init()) {
    self.actionCreator = actionCreator
  }

  var body: some View {
    SearchNavigation(text: $store.searchQuery, search: { actionCreator.searchUsers(searchQuery: store.searchQuery) }) {
      List {
        ForEach(store.userListState.users) { user in
          UserListRow(user: user)
        }
        HStack {
          Spacer()
          ActivityIndicator()
            .onAppear {
              actionCreator.additionalSearchUsers(searchQuery: store.searchQuery, page: store.page)
            }
          Spacer()
        }
        // 次のページがない場合、リスト末尾にインジケーターを表示しない
        .hidden(!store.hasNext)
      }
      .alert(isPresented: $store.isErrorShown) { () -> Alert in
        Alert(title: Text(store.errorTitle), message: Text(store.errorMessage))
      }
      .navigationBarTitle(Text("Users"))
    }
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

#if DEBUG
  struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        UserListView()
          .preferredColorScheme($0)
      }
    }
  }
#endif
