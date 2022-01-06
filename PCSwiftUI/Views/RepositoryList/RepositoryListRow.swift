//
//  RepositoryListRow.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import SwiftUI

struct RepositoryListRow: View {

  @State var repository: Repository

  var body: some View {
    NavigationLink(destination: RepositoryDetailView(repository: repository)) {
      Text(repository.fullName)
    }
  }
}

#if DEBUG
  struct RepositoryListRow_Previews: PreviewProvider {
    static var previews: some View {
      RepositoryListRow(
        repository: Repository(
          id: 1,
          fullName: "foo",
          owner: User(
            id: 1,
            login: "bar",
            avatarUrl: URL(string: "baz")!,
            htmlUrl: "https://api.github.com/users/octocat/repos"
          )
        )
      )
    }
  }
#endif
