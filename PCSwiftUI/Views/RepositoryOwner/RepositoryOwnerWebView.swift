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
    WebView(urlString: repository.owner.htmlUrl.absoluteString)
  }
}

#if DEBUG
  struct RepositoryOwnerWebView_Previews: PreviewProvider {
    static var previews: some View {
      RepositoryOwnerWebView(
        repository: Repository(
          id: 1_300_192.description,
          fullName: "octocat/Spoon-Knife",
          description: "This repo is for demonstration purposes only.",
          stargazersCount: 10673,
          language: "HTML",
          owner: User(
            id: 583231.description,
            login: "octocat",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
            htmlUrl: URL(string: "https://github.com/octocat")!
          )
        )
      )
    }
  }
#endif
