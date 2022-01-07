//
//  RepositoryOwnerWebView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import SwiftUI

struct RepositoryOwnerWebView: View {
  var repository: Repository

  var body: some View {
    if repository.owner.htmlUrl.isEmpty {
      Text("No link")
    } else {
      WebView(urlString: repository.owner.htmlUrl)
    }
  }
}

#if DEBUG
  struct RepositoryOwnerWebView_Previews: PreviewProvider {
    static var previews: some View {
      RepositoryOwnerWebView(
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